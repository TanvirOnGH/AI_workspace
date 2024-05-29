/* Based on: https://gist.github.com/Artefact2/fd2254fc133906ac96b49b6947f0cd4a */

#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s file.gguf\n", argv[0]);
        return 1;
    }

    int src_fd = open(argv[1], O_RDONLY);
    if (src_fd == -1)
    {
        perror("src open()");
        return 1;
    }
    off_t src_len = lseek(src_fd, 0, SEEK_END);
    if (src_len == -1)
    {
        perror("lseek()");
        return 1;
    }
    lseek(src_fd, 0, SEEK_SET);

    /* 50GB (NOT GiB) */
    const off_t BSIZE = 372 * 128 * 1024 * 1024l; /* Must be a multiple of CFRSIZE */
    const size_t CFRSIZE = 128 * 1024 * 1024l;
    if (src_len < BSIZE)
        return 0; /* No need to split */

    unsigned int n = 0;
    char dest_path[strlen(argv[1]) + 10];
    int dest_fd;
    for (off_t i = 0; i < src_len; i += BSIZE)
    {
        snprintf(dest_path, sizeof(dest_path) - 1, "%s.%03u", argv[1], n);
        dest_fd = open(dest_path, O_CREAT | O_TRUNC | O_WRONLY, 0666);
        if (dest_fd == -1)
        {
            perror("dest open()");
            return 1;
        }
        for (off_t k = 0; k < BSIZE; k += CFRSIZE)
        {
            if (copy_file_range(src_fd, NULL, dest_fd, NULL, CFRSIZE, 0) == -1)
            {
                perror("copy_file_range()");
                return 1;
            }
        }
        close(dest_fd);
        printf("%s\n", dest_path);
        n += 1;
    }
    close(src_fd);
    return 0;
}
