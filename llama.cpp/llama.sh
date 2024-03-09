#!/bin/sh

llama -m /home/user/workspace/ollama/models/mixtral-8x7b-instruct-v0.1.Q3_K_M.gguf --interactive-first -ngl 7 --in-prefix " <s>[INST] " --in-suffix " [/INST] "
