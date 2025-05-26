#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"


char *fmtname(char *path)
{
    static char buf[DIRSIZ + 1];
    char *p;

    // Find first character after last slash.
    for (p = path + strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;

    // Return blank-padded name.
    if (strlen(p) >= DIRSIZ)
        return p;
    memmove(buf, p, strlen(p));
    memset(buf + strlen(p), ' ', DIRSIZ - strlen(p));
    buf[DIRSIZ] = '\0';  // Ensure null termination
    return buf;
}

// Format permissions as "rw", "r-", "-w", or "--"
char* fmtmode(int minor)
{
    static char perm[3];
    
    // Check read permission (bit 0)
    perm[0] = (minor & 0x1) ? 'r' : '-';
    
    // Check write permission (bit 1)
    perm[1] = (minor & 0x2) ? 'w' : '-';
    
    // Null terminator
    perm[2] = '\0';
    
    return perm;
}

// Helper function to check if a path has read permission for all parent directories
int check_path_permissions(char *path)
{
    char temp_path[512];
    char *p;
    int fd;
    struct stat st;
    
    // Make a copy of the path to modify
    strcpy(temp_path, path);
    
    // Check each parent directory in the path
    p = temp_path;
    if (*p == '/') p++; // Skip root '/'
    
    while ((p = strchr(p, '/')) != 0) {
        *p = '\0'; // Temporarily terminate the path at this directory
        
        // Try to open this directory component
        fd = open(temp_path[0] ? temp_path : "/", O_NOACCESS);
        if (fd < 0) {
            return 0; // Can't access this directory
        }
        
        if (fstat(fd, &st) < 0) {
            close(fd);
            return 0;
        }
        
        close(fd);
        
        // Check if this directory has read permission
        if (st.type == T_DIR && !(st.minor & 0x1)) {
            return 0; // Directory doesn't have read permission
        }
        
        *p = '/'; // Restore the '/'
        p++; // Move to next component
    }
    
    return 1; // All parent directories have read permission
}

/* TODO: Access Control & Symbolic Link */
void ls(char *path)
{
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    // Open with O_NOACCESS first to get metadata
    if ((fd = open(path, O_NOACCESS)) < 0)
    {
        fprintf(2, "ls: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0)
    {
        fprintf(2, "ls: cannot open %s\n", path);
        close(fd);
        return;
    }
    
    switch (st.type)
    {
    case T_FILE:
        printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
        break;
        
    case T_SYMLINK:
        {
            char target[512];
            int target_fd;
            struct stat target_st;
            
            // Read the symlink target from the inode data
            // Since in the sys_symlink() function in sysfile.c, we wrote the target path to the inode data by writei()
            memset(target, 0, sizeof(target));
            if (read(fd, target, sizeof(target)) < 0) {
                printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
                break;
            }
            
            // Try to open the target with O_NOACCESS first
            target_fd = open(target, O_NOACCESS);
            if (target_fd < 0) {
                // If target path isn't accessible, show symlink itself
                printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
                break;
            }
            
            if (fstat(target_fd, &target_st) < 0) {
                close(target_fd);
                printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
                break;
            }
            
            close(target_fd);
            
            // If target is a directory, try to list its contents
            if (target_st.type == T_DIR) {
                // Check if path to target is readable
                if (check_path_permissions(target)) {
                    ls(target);  // List the target directory
                } else {
                    // If target directory isn't accessible, ls should fail
                    printf("ls: cannot open %s\n", target);
                }
            } else {        // if target is a file
                // check the path of the file to see if each of the parent directories have read permission
                if (check_path_permissions(target)) {
                    printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
                } else {
                    printf("ls: cannot open %s\n", target);
                }
            }
        }
        break;

    case T_DIR:
        if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf) {
            printf("ls: path too long\n");
            break;
        }

        // Close the O_NOACCESS fd and reopen with O_RDONLY for reading contents
        close(fd);
        
        // From the spec: "A directory, or a symbolic link to a directory, will only be opened with either O_RDONLY or O_NOACCESS"
        // For listing contents, we need O_RDONLY
        fd = open(path, O_RDONLY);
        if (fd < 0) {
            fprintf(2, "ls: cannot open %s\n", path);
            return;
        }
        
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';
        while (read(fd, &de, sizeof(de)) == sizeof(de))
        {
            if (de.inum == 0)
                continue;
            
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            
            // Special handling for "." and ".." to avoid stat errors
            if(strcmp(de.name, ".") == 0) {
                printf("%s %d %d %d %s\n", 
                       fmtname(de.name), 
                       T_DIR,           // Type is always directory for . and ..
                       de.inum,         // Use the inode number from dirent
                       st.size,         // Size from parent directory's stat
                       fmtmode(st.minor)); // Permissions from parent directory
                continue;
            }
            
            if(strcmp(de.name, "..") == 0) {
                printf("%s %d %d %d %s\n", 
                       fmtname(de.name), 
                       T_DIR,           // Type is always directory for . and ..
                       de.inum,         // Use the inode number from dirent
                       st.size,         // Size from parent directory's stat
                       fmtmode(st.minor)); // Permissions from parent directory
                continue;
            }
            
            // Try to get entry stats with O_NOACCESS
            int entry_fd = open(buf, O_NOACCESS);
            struct stat entry_st;
            
            // Debug prints
            // fprintf(2, "DEBUG_LS: Trying to open entry '%s'\n", de.name);
            if (entry_fd < 0) {
                // fprintf(2, "DEBUG_LS: open() failed for '%s', entry_fd = %d\n", de.name, entry_fd);
            }
            
            if (entry_fd >= 0 && fstat(entry_fd, &entry_st) < 0) {
                // fprintf(2, "DEBUG_LS: fstat() failed for '%s'\n", de.name);
            }
            
            if (entry_fd < 0 || fstat(entry_fd, &entry_st) < 0) {
                // Even if we can't open the entry (no read permission),
                // we should still be able to get its inode info from the directory entry
                struct stat fallback_st;
                fprintf(2, "DEBUG_LS: Trying fallback stat() for '%s'\n", de.name);
                if (stat(buf, &fallback_st) >= 0) {
                    printf("%s %d %d %d %s\n", 
                           fmtname(de.name), 
                           fallback_st.type, 
                           fallback_st.ino, 
                           fallback_st.size, 
                           fmtmode(fallback_st.minor));
                    // fprintf(2, "DEBUG_LS: Fallback stat() succeeded for '%s'\n", de.name);
                } else {
                    // fprintf(2, "DEBUG_LS: Fallback stat() also failed for '%s'\n", de.name);
                }
            } else {
                printf("%s %d %d %d %s\n", 
                       fmtname(de.name), 
                       entry_st.type, 
                       entry_st.ino, 
                       entry_st.size, 
                       fmtmode(entry_st.minor));
                close(entry_fd);
            }
        }
        break;
    }
    
    close(fd);
}

int main(int argc, char *argv[])
{
    int i;

    if (argc < 2)
    {
        ls(".");
        exit(0);
    }
    
    for (i = 1; i < argc; i++)
        ls(argv[i]);
        
    exit(0);
}
