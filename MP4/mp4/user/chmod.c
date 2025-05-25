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
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, O_RDONLY)) < 0) {
        fprintf(2, "chmod: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0) {
        fprintf(2, "chmod: cannot stat %s\n", path);
        close(fd);
        return;
    }

    chmod(path, mode);

    if(st.type == T_DIR) {
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
            printf("chmod: path too long\n");
            close(fd);
            return;
        }
        strcpy(buf, path);
        p = buf+strlen(buf);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)) {
            if(de.inum == 0)
                continue;
            if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            recursive_chmod(buf, mode);
        }
    }
    close(fd);
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