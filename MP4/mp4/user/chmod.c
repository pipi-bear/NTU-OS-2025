#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void usage() {
    // Print the required usage message to stderr
    fprintf(2, "Usage: chmod [-R] (+|-) (r|w|rw|wr) file_name|dir_name\n");
    exit(1);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        usage();
    }

    int mode = 0;
    char *perm = argv[1];
    if (perm[0] != '+' && perm[0] != '-') {
        usage();
    }

    // read = 1, write = 2, read & write = 3
    if (perm[1] == 'r') mode |= 1;
    if (perm[1] == 'w' || (perm[2] && perm[2] == 'w')) mode |= 2;
    if (perm[1] == 'r' && perm[2] && perm[2] == 'w') mode |= 2;

    if (perm[0] == '-') {
        // Remove permissions by using bitwise AND with ~mode
        mode = 3 & ~mode;
    }

    // Call the syscall
    if (chmod(argv[2], mode) < 0) {
        fprintf(2, "chmod: cannot chmod %s\n", argv[2]);
        exit(1);
    }

    exit(0);
}