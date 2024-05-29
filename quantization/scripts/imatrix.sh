#!/usr/bin/sh
# Based on: https://gist.github.com/Artefact2/fd2254fc133906ac96b49b6947f0cd4a

BASE=$1
M=$(basename $1)
IMQ=f16

if [ -f $BASE-imatrix.dat ]; then
    exit 0
fi

if [ ! -f $BASE-$IMQ.gguf ]; then
    make clean && make quantize || exit 1
    ./quantize $BASE-f16.gguf $BASE-$IMQ.gguf.tmp $IMQ && mv -f $BASE-$IMQ.gguf.tmp $BASE-$IMQ.gguf
fi

make clean && make LLAMA_HIPBLAS=1 AMDGPU_TARGETS=gfx1030 imatrix || exit 1

HORDE=$(systemctl --user is-active --quiet horde-bridge.service)
[ "x$HORDE" = "xactive" ] && systemctl --user stop horde-bridge.service
./imatrix -m $BASE-$IMQ.gguf -f wiki.train.raw --chunks 200 --no-ppl -ofreq 200 --no-mmap -ngl 7 || exit 1
[ "x$HORDE" = "xactive" ] && systemctl --user start horde-bridge.service
mv -f imatrix.dat $BASE-imatrix.dat || exit 1

if [ "$IMQ" != "f16" ]; then
    rm -f $BASE-$IMQ.gguf
fi

. ../huggingface-cli/bin/activate
HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli upload Artefact2/$M-GGUF $BASE-imatrix.dat
