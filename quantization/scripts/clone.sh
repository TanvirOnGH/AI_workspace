#!/usr/bin/sh
# Based on: https://gist.github.com/Artefact2/fd2254fc133906ac96b49b6947f0cd4a

URI=$1
BASE=$(basename $1)

[ -f ../models/$BASE-f16.gguf ] && exit 0

(. ../huggingface-cli/bin/activate && HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download $URI --local-dir ../models/$BASE --cache-dir ../models/$BASE/.hf-cache --exclude 'pytorch_model*' --exclude 'consolidated*' --resume-download) || exit 1

DTYPE=$(jq -r '.torch_dtype' <../models/$BASE/config.json)
if [ "$DTYPE" = "float16" ]; then
    OUTTYPE=f16
else
    OUTTYPE=f32
fi

. ./venv/bin/activate
./convert.py --outtype $OUTTYPE --outfile ../models/$BASE-f16.gguf.tmp ../models/$BASE || exit 1
mv -f ../models/$BASE-f16.gguf.tmp ../models/$BASE-f16.gguf || exit 1

if [ -f ../models/$BASE-f16.gguf ]; then
    rm -Rf ../models/$BASE
fi
