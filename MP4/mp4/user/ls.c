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

/* TODO: Access Control & Symbolic Link */
void ls(char *path)
{
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, O_NOACCESS)) < 0)
    {
        fprintf(2, "ls: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0)
    {
        fprintf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }
    
    switch (st.type)
    {
    case T_FILE:
        printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
        break;
    case T_SYMLINK:
        printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
        break;

    case T_DIR:
        // First print directory info from O_NOACCESS fd
        printf("%s %d %d %d %s\n", fmtname(path), st.type, st.ino, st.size, fmtmode(st.minor));
        
        // Close the O_NOACCESS fd 
        close(fd);
        
        // From the spec: "A directory, or a symbolic link to a directory, will only be opened with either O_RDONLY or O_NOACCESS"
        // For listing contents, we need O_RDONLY
        fd = open(path, O_RDONLY);
        if (fd < 0) {
            // This will fail if the directory doesn't have read permission
            fprintf(2, "ls: cannot open directory %s for reading\n", path);
            return;
        }
        
        if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf)
        {
            printf("ls: path too long\n");
            close(fd);
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
            if(strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) {
                // For "." and "..", just print them directly with the inode information
                printf("%s %d %d %d %s\n", 
                       fmtname(de.name), 
                       T_DIR,           // Type is always directory for . and ..
                       de.inum,         // Use the inode number from dirent
                       st.size,         // Size from parent directory's stat
                       fmtmode(st.minor)); // Permissions from parent directory
                continue;
            }
            
            // Use O_NOACCESS alone for each entry per spec
            int entry_fd = open(buf, O_NOACCESS);
            if (entry_fd < 0)
                continue;
                
            struct stat entry_st;
            if (fstat(entry_fd, &entry_st) < 0) {
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
