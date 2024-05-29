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
    if (argc < 3)
    {
        fprintf(stderr, "Usage: %s file.000 file.001... merge.out\n", argv[0]);
        return 1;
    }

    int dest_fd = open(argv[argc - 1], O_CREAT | O_TRUNC | O_WRONLY, 0666);
    if (dest_fd == -1)
    {
        perror("dest open()");
        return 1;
    }
    const size_t CFRSIZE = 2048 * 1024 * 1024l;

    for (int i = 1; i < argc - 1; ++i)
    {
        int in_fd = open(argv[i], O_RDONLY);
        if (in_fd == -1)
        {
            perror("in open()");
            return 1;
        }

        ssize_t ret;
        /* copy_file_range() returns 0 on EOF */
        while ((ret = copy_file_range(in_fd, NULL, dest_fd, NULL, CFRSIZE, 0)) != 0)
        {
            if (ret == -1)
            {
                perror("copy_file_range()");
                return 1;
            }
        }
        close(in_fd);
    }

    close(dest_fd);
    return 0;
}
