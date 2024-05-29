#!/usr/bin/sh
# Based on: https://gist.github.com/Artefact2/fd2254fc133906ac96b49b6947f0cd4a

URI=$1
BASE=$(basename $1)

./clone.sh $URI || exit 1
./imatrix.sh ../models/$BASE || exit 1
./quantize.sh ../models/$BASE || exit 1
truncate -s0 ../models/$BASE-f16.gguf
