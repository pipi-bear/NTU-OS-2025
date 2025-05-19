#define O_RDONLY 0x000      // open for reading only
#define O_WRONLY 0x001      // open for writing only
#define O_RDWR 0x002        // open for reading and writing
#define O_CREATE 0x200      // create if the file does not exist
#define O_TRUNC 0x400       // truncate the file to zero length
/* The following line is added by me */
#define O_NOFOLLOW 0x800    // do not follow symlinks
