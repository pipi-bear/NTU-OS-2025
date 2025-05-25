#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/param.h"  // includes MAXPATH definition

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

/* TODO: Access Control & Symbolic Link */
void ls(char *path)
{
    char buf[512], *p;        // Buffer for constructing full paths when listing directory contents
    int fd;                   // File descriptor
    struct dirent de;         // Directory entry structure
    struct stat st;           // Metadata of the file/directory

    fprintf(2, "DEBUG: Starting ls for path: %s\n", path);
    
    // Try to open with O_RDONLY first to check read permission
    fd = open(path, O_RDONLY);
    if (fd < 0) {
        fprintf(2, "ls: cannot open %s\n", path);
        return;
    }
    fprintf(2, "DEBUG: Opened file with fd: %d\n", fd);

    // Use fstat to get the metadata of the opened file / directory
    if (fstat(fd, &st) < 0) {
        fprintf(2, "DEBUG: fstat failed\n");
        close(fd);
        return;
    }
    fprintf(2, "DEBUG: File type: %d\n", st.type);

    switch (st.type) {
    case T_FILE:
        // For files, just print info since we already checked read permission with O_RDONLY
        fprintf(2, "DEBUG: Processing regular file\n");
        printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
        close(fd);
        return;

    case T_DIR:
        // For directories, we already checked read permission with O_RDONLY
        // Now list contents
        fprintf(2, "DEBUG: Processing directory\n");
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
            if (de.inum == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            fprintf(2, "DEBUG: Processing directory entry: %s\n", de.name);
            
            int entry_fd = open(buf, O_NOACCESS);
            if (entry_fd < 0) {
                fprintf(2, "DEBUG: Failed to open entry: %s\n", buf);
                continue;
            }
                
            struct stat entry_st;
            if (fstat(entry_fd, &entry_st) < 0) {
                fprintf(2, "DEBUG: Failed to stat entry: %s\n", buf);
                close(entry_fd);
                continue;
            }
            
            printf("%s %d %d %d %s\n", 
                   fmtname(de.name), 
                   entry_st.type, 
                   entry_st.ino, 
                   entry_st.size, 
                   fmtmode(entry_st.minor));
                   
            close(entry_fd);
        }
        close(fd);
        return;

    case T_SYMLINK:
        fprintf(2, "DEBUG: Processing symlink\n");
        {
            char target[MAXPATH];
            struct stat target_st;
            
            // Read the target path so that we can know if this symlink points to a directory or a file
            int n = read(fd, target, MAXPATH-1);
            if (n <= 0) {
                fprintf(2, "DEBUG: Failed to read symlink target\n");
                close(fd);
                return;
            }
            target[n] = 0;  // Ensure null termination
            close(fd);  // Close the symlink fd before proceeding
            
            fprintf(2, "DEBUG: Symlink target path: %s\n", target);

            // Try to open target with O_RDONLY
            int target_fd = open(target, O_RDONLY);
            if (target_fd < 0) {
                // Cannot open target - just print symlink info
                fd = open(path, O_NOACCESS);
                if (fd < 0) {
                    fprintf(2, "DEBUG: Failed to reopen symlink\n");
                    return;
                }
                if (fstat(fd, &st) < 0) {
                    fprintf(2, "DEBUG: Failed to stat symlink\n");
                    close(fd);
                    return;
                }
                printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
                close(fd);
                return;
            }

            if (fstat(target_fd, &target_st) < 0) {
                fprintf(2, "DEBUG: Failed to stat target\n");
                close(target_fd);
                return;
            }

            if (target_st.type == T_DIR) {
                // For symlink to directory:
                // List directory contents since we have read permission
                fprintf(2, "DEBUG: Target is directory\n");
                strcpy(buf, target);
                p = buf + strlen(buf);
                *p++ = '/';
                while (read(target_fd, &de, sizeof(de)) == sizeof(de)) {
                    if (de.inum == 0)
                        continue;
                    memmove(p, de.name, DIRSIZ);
                    p[DIRSIZ] = 0;
                    
                    int entry_fd = open(buf, O_NOACCESS);
                    if (entry_fd < 0) {
                        fprintf(2, "DEBUG: Failed to open entry in target: %s\n", buf);
                        continue;
                    }
                        
                    struct stat entry_st;
                    if (fstat(entry_fd, &entry_st) < 0) {
                        fprintf(2, "DEBUG: Failed to stat entry in target: %s\n", buf);
                        close(entry_fd);
                        continue;
                    }
                    
                    printf("%s %d %d %d %s\n", 
                           fmtname(de.name), 
                           entry_st.type, 
                           entry_st.ino, 
                           entry_st.size, 
                           fmtmode(entry_st.minor));
                           
                    close(entry_fd);
                }
                close(target_fd);
            } else {
                // For symlink to file:
                // Just print symlink info since parent directories are readable
                fprintf(2, "DEBUG: Target is file\n");
                close(target_fd);  // Close target_fd before opening symlink again
                fd = open(path, O_NOACCESS);
                if (fd < 0) {
                    fprintf(2, "DEBUG: Failed to reopen symlink\n");
                    return;
                }
                if (fstat(fd, &st) < 0) {
                    fprintf(2, "DEBUG: Failed to stat symlink\n");
                    close(fd);
                    return;
                }
                printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
                close(fd);
            }
            return;
        }
    }
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
