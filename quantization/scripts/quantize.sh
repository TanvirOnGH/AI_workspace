#!/usr/bin/sh
# Based on: https://gist.github.com/Artefact2/fd2254fc133906ac96b49b6947f0cd4a

BASE=$1
M=$(basename $1)

make clean && make quantize || exit 1

. ../huggingface-cli/bin/activate

for x in Q{4,5}_K_{S,M} Q6_K IQ4_XS IQ{3,2}_{M,S,XS,XXS} IQ1_S; do
    if [ ! -f $BASE-$x.gguf ]; then
        ./quantize --imatrix $BASE-imatrix.dat $BASE-f16.gguf $BASE-$x.gguf.tmp $x || exit 1
        mv -f $BASE-$x.gguf.tmp $BASE-$x.gguf || exit 1
        ./split $BASE-$x.gguf || exit 1

        while pgrep -f huggingface-cli >/dev/null; do
            sleep 5
        done

        if [ -f $BASE-$x.gguf.000 ]; then
            (HF_HUB_ENABLE_HF_TRANSFER=1 parallel --env HF_HUB_ENABLE_HF_TRANSFER --ungroup -n1 -j1 "huggingface-cli upload Artefact2/$M-GGUF {} && truncate -s0 {}" ::: $BASE-$x.gguf.*) &
        else
            (HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli upload Artefact2/$M-GGUF $BASE-$x.gguf && truncate -s0 $BASE-$x.gguf) &
        fi
    fi
done
