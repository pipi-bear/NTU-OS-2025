// xv6 specific headers
#include "kernel/types.h"   // types like int, uint...
#include "kernel/stat.h"    // functions to retrieve metadata (we need to get the file type)
#include "user/user.h"      // functions under users (like printf, mkdir,...)
#include "kernel/fs.h"      // file system structures (like dirent)
// Manually define NULL
#ifndef NULL
#define NULL ((void*)0)
#endif

#define MAX_BUF 512  // Set buffer size limit since xv6 does not have malloc()

// Manually implement strstr() 
// funct def: char *strstr (const char *s1, const char *s2);
// explain: strstr() finds the first occurrence of the string s2 in the string s1
char *strstr(const char *haystack, const char *needle) {
    if (!*needle) return (char *)haystack;

    for (; *haystack; haystack++) {
        if (*haystack == *needle) {
            const char *h, *n;
            for (h = haystack, n = needle; *h && *n && *h == *n; h++, n++);
            if (!*n) return (char *)haystack;
        }
        if (*haystack == '\0') break; // Ensure the pointer does not go out of bounds
    }
    return NULL;
}


// Traverse through the directories and files under <root_directory> and count their amount
void traverse_directory(char *path, char *key, int *file_count, int *dir_count, int pipe_fd[2], char *root_directory) {
    int fd;
    struct stat st;
    // explain: dirent = Directory entry (stores inode number and name)
    struct dirent de;       
    char buf[MAX_BUF], *p;

    // Open the directory.
    // funct def: int fd = open(const char *path, int flags);
    // explain: fd is an int that is assigned to refer to the file when we use open()
    if ((fd = open(path, 0)) < 0) {             // fd < 0  means that open() failed (file does not exist)
        printf("%s [error opening dir]\n", path);
        return;
    }

    // Check if it is a file or a directory
    // funct def: int fstat(int fd, struct stat *buf);
    // explain: *buf: ptr to a struct stat that the file info will be stored
    // explain: fstat() usese fd to get the metadata of the opened file, and store them in &st
    if (fstat(fd, &st) < 0) {
        printf("Error: Cannot stat %s\n", path);
        close(fd);
        return;
    }

    // Case: If it's a file, check for the key
    if (st.type == T_FILE) {
        (*file_count)++;
        printf("Found a file and now file count = %d\n", *file_count);

        // Open file and check for key occurrences
        int key_count = 0;
        char *ptr = path;

        
        // ex: os2025/d2/d3/a 2     key[] = "d";
        // ex: 1. strstr(ptr, key) points to "d2/d3/a", ptr++ points to "2/d3/a"
        // ex: 2. strstr(ptr, key) points to "d3/a", ptr++ points to "3/a"
        // ex: 3. strstr(ptr, key) points to NULL, exit while loop 
        while ((ptr = strstr(ptr, key)) != NULL) {
            key_count++;
            ptr++;  // Move the ptr one char forward to search for the next occurrence
        }

        // Print the file path and the amount of key that has been counted
        printf("%s %d\n", path, key_count);
        close(fd);
        return;
    }

    // Case: If it's a directory, recurse into it
    if (st.type == T_DIR) {
        // We do not count the root directory in the amount of directories
        if (strcmp(path, root_directory) != 0) {
            (*dir_count)++;
            printf("Found a directory and now dir count = %d\n", *dir_count);
        }
    
        int key_count = 0;
        char *ptr = path;
        printf("Searching for key in %s\n", path);
        while ((ptr = strstr(ptr, key)) != NULL)
        {
            printf("Found key in %s\n", ptr);
            key_count++;
            ptr++;
            printf("Modified key count = %d, ptr position = %s\n", key_count, ptr);
        }

        printf("%s %d\n", path, key_count);
    
        // Read directory entries
        while (read(fd, &de, sizeof(de)) == sizeof(de)) {
            
            // Construct the full path
            // strcpy(buf, path);
            // p = buf + strlen(buf);
            // *p++ = '/';
            // strcpy(p, de.name);

            snprintf(buf, sizeof(buf), "%s/%s", path, de.name);
    
            // Recursively call function for the subdirectories and files
            traverse_directory(buf, key, file_count, dir_count, pipe_fd, root_directory);
        }
    }
    close(fd);
}

int main(int argc, char *argv[]) {

    char *root_directory = argv[1];
    char *key = argv[2];

    // Create a pipe with pipe_fd[0] the read end, and pipe_fd[1] the write end
    int pipe_fd[2];
    pipe(pipe_fd);

    int file_count = 0, dir_count = 0;

    if (fork() == 0) {
        // case: Child Process: Count the number of files / directories and pass to the parent process
        close(pipe_fd[0]); 
        traverse_directory(root_directory, key, &file_count, &dir_count, pipe_fd, root_directory);
        
        printf("\n");   // print blank line between child and parent output

        write(pipe_fd[1], &dir_count, sizeof(dir_count));
        write(pipe_fd[1], &file_count, sizeof(file_count));
        
        // Close write end to ensure parent gets EOF and ends reading 
        close(pipe_fd[1]); 
        exit(0);
    } else {
        // case: Parent Process: Read results from pipe
        close(pipe_fd[1]); // Close the write end of the pipe
        wait(0);           // Ensure reading after the child writes

        read(pipe_fd[0], &dir_count, sizeof(dir_count));
        read(pipe_fd[0], &file_count, sizeof(file_count));

        printf("%d directories, %d files\n", dir_count, file_count);
        close(pipe_fd[0]); // Close the read end of the pipe
    }

    exit(0);
}