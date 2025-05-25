#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"

void usage() {
    // Print the required usage message to stderr
    fprintf(2, "Usage: chmod [-R] (+|-)(r|w|rw|wr) file_name|dir_name\n");
    exit(1);
}

void recursive_chmod(char *path, int mode) {
    struct stat st;
    struct dirent de;
    int fd;
    char buf[512], *p;
    // Check if we're adding or removing permissions 
    // explain: since the approach would differ using top-down (remove) or bottom-up (add)
    // read = 0x1, write = 0x2
    int is_add = (mode & 0x1) || (mode & 0x2);

    // Get file/directory information
    if(stat(path, &st) < 0)
        return;

    if(st.type == T_DIR) {
        // Always open with O_NOACCESS to ensure we can read directory contents
        fd = open(path, O_NOACCESS);
        if(fd < 0)
            return;

        // For removing permissions (top-down):
        // 1. Change parent permissions first
        // 2. Then process children
        if(!is_add) {
            chmod(path, mode);
        }

        // Process all children
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';

        // Process directory entries
        while(read(fd, &de, sizeof(de)) == sizeof(de)) {
            if(de.inum == 0)
                continue;
            if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            recursive_chmod(buf, mode);
        }
        close(fd);

        // For adding permissions (bottom-up):
        // 1. Process all children first (done above)
        // 2. Then change parent permissions
        if(is_add) {
            chmod(path, mode);
        }
    } else {
        // For regular files, simply change mode
        chmod(path, mode);
    }
}

int main(int argc, char *argv[]) {
    int recursive = 0;
    char *perm;
    char *path;

    if (argc < 3 || argc > 4) {
        usage();
    }

    // Parse arguments
    if (strcmp(argv[1], "-R") == 0) {
        if (argc != 4) usage();
        recursive = 1;
        perm = argv[2];
        path = argv[3];
    } else {
        if (argc != 3) usage();
        perm = argv[1];
        path = argv[2];
    }

    // Check permission format
    if (perm[0] != '+' && perm[0] != '-') {
        usage();
    }

    int mode = 0;
    // read = 1, write = 2, read & write = 3
    if (perm[1] == 'r') mode |= 1;
    if (perm[1] == 'w' || (perm[2] && perm[2] == 'w')) mode |= 2;
    if (perm[1] == 'r' && perm[2] && perm[2] == 'w') mode |= 2;

    if (perm[0] == '-') {
        // Remove permissions by using bitwise AND with ~mode
        mode = 3 & ~mode;
    }

    // Call chmod recursively or non-recursively based on the flag
    if (recursive) {
        recursive_chmod(path, mode);
    } else {
        if (chmod(path, mode) < 0) {
            fprintf(2, "chmod: cannot chmod %s\n", path);
            exit(1);
        }
    }

    exit(0);
}