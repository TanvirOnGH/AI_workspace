#!/bin/sh
# nix shell github:ggerganov/llama.cpp/mixtral#package
#nix shell github:ggerganov/llama.cpp/mixtral#cuda --impure
nix shell ./#cuda --impure
