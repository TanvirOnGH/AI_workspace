# References

- [Which GGUF is right for me? (Opinionated)](https://gist.github.com/Artefact2/b5f810600771265fc1e39442288e8ec9)
- [calibration_datav3.txt](https://gist.github.com/bartowski1182/eb213dccb3571f863da82e99418f81e8) - Used for calibrating GGUF imatrix files
- [calibration_data.txt](https://gist.github.com/bartowski1182/b6ac44691e994344625687afe3263b3a)
- [Tensor Encoding Schemes](https://github.com/ggerganov/llama.cpp/wiki/Tensor-Encoding-Schemes)
- [llama.cpp Feature matrix](https://github.com/ggerganov/llama.cpp/wiki/Feature-matrix)
- [ggify](https://github.com/akx/ggify) -  Tool to download models from Huggingface Hub and convert them to GGML for llama.cpp
- [Convert model to GGUF (llama.cpp)](https://github.com/ggerganov/llama.cpp/blob/master/docs/HOWTO-add-model.md#1-convert-the-model-to-gguf)
- [GGUF specification](https://github.com/ggerganov/ggml/blob/master/docs/gguf.md)
- [gguf-my-repo](https://huggingface.co/spaces/ggml-org/gguf-my-repo) Huggingface space to create your own GGUF Quants, blazingly fast and easy.

## Explanation of Quantization methods

| Quant type | Description                                                                                                          |
| ---------- | -------------------------------------------------------------------------------------------------------------------- |
| Q8_0       | Extremely high quality, generally unneeded but max available quant.                                                  |
| Q6_K       | Very high quality, near perfect, *recommended*.                                                                      |
| Q5_K_M     | High quality, *recommended*.                                                                                         |
| Q5_K_S     | High quality, *recommended*.                                                                                         |
| Q4_K_M     | Good quality, uses about 4.83 bits per weight, *recommended*.                                                        |
| Q4_K_S     | Slightly lower quality with more space savings, *recommended*.                                                       |
| IQ4_NL     | Decent quality, slightly smaller than Q4_K_S with similar performance *recommended*.                                 |
| IQ4_XS     | Decent quality, smaller than Q4_K_S with similar performance, *recommended*.                                         |
| Q3_K_L     | Lower quality but usable, good for low RAM availability.                                                             |
| Q3_K_M     | Even lower quality.                                                                                                  |
| IQ3_M      | Medium-low quality, new method with decent performance comparable to Q3_K_M.                                         |
| IQ3_S      | Lower quality, new method with decent performance, recommended over Q3_K_S quant, same size with better performance. |
| Q3_K_S     | Low quality, not recommended.                                                                                        |
| IQ3_XS     | Lower quality, new method with decent performance, slightly better than Q3_K_S.                                      |
| IQ3_XXS    | Lower quality, new method with decent performance, comparable to Q3 quants.                                          |
| Q2_K       | Very low quality but surprisingly usable.                                                                            |
| IQ2_M      | Very low quality, uses SOTA techniques to also be surprisingly usable.                                               |
| IQ2_S      | Very low quality, uses SOTA techniques to be usable.                                                                 |
| IQ2_XS     | Very low quality, uses SOTA techniques to be usable.                                                                 |
| IQ2_XXS    | Lower quality, uses SOTA techniques to be usable.                                                                    |
| IQ1_M      | Extremely low quality, *not* recommended.                                                                            |
| IQ1_S      | Extremely low quality, *not* recommended.                                                                            |

## Quantization Types

[Source](https://github.com/huggingface/hub-docs/blob/main/docs/hub/gguf.md)

| type         | source | description |
|---------------------------|--------|-------------|
| F64 | [Wikipedia](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) | 64-bit standard IEEE 754 double-precision floating-point number. |
| I64 | [GH](https://github.com/ggerganov/llama.cpp/pull/6062) | 64-bit fixed-width integer number. |
| F32  | [Wikipedia](https://en.wikipedia.org/wiki/Single-precision_floating-point_format) | 32-bit standard IEEE 754 single-precision floating-point number. |
| I32 | [GH](https://github.com/ggerganov/llama.cpp/pull/6045) | 32-bit fixed-width integer number. |
| F16  | [Wikipedia](https://en.wikipedia.org/wiki/Half-precision_floating-point_format) | 16-bit standard IEEE 754 half-precision floating-point number. |
| BF16 | [Wikipedia](https://en.wikipedia.org/wiki/Bfloat16_floating-point_format) | 16-bit shortened version of the 32-bit IEEE 754 single-precision floating-point number. |
| I16 | [GH](https://github.com/ggerganov/llama.cpp/pull/6045) | 16-bit fixed-width integer number. |
| Q8_0 | [GH](https://github.com/huggingface/huggingface.js/pull/615#discussion_r1557654249) | 8-bit round-to-nearest quantization (`q`). Each block has 32 weights. Weight formula: `w = q * block_scale`. Legacy quantization method (not used widely as of today). |
| Q8_1 | [GH](https://github.com/huggingface/huggingface.js/pull/615#discussion_r1557682290) | 8-bit round-to-nearest quantization (`q`). Each block has 32 weights. Weight formula: `w = q * block_scale + block_minimum`. Legacy quantization method (not used widely as of today) |
| Q8_K | [GH](https://github.com/ggerganov/llama.cpp/pull/1684#issue-1739619305) | 8-bit quantization (`q`). Each block has 256 weights. Only used for quantizing intermediate results. All 2-6 bit dot products are implemented for this quantization type. Weight formula: `w = q * block_scale`. |
| I8 | [GH](https://github.com/ggerganov/llama.cpp/pull/6045) | 8-bit fixed-width integer number. |
| Q6_K | [GH](https://github.com/ggerganov/llama.cpp/pull/1684#issue-1739619305) | 6-bit quantization (`q`). Super-blocks with 16 blocks, each block has 16 weights. Weight formula: `w = q * block_scale(8-bit)`, resulting in 6.5625 bits-per-weight. |
| Q5_0 | [GH](https://github.com/huggingface/huggingface.js/pull/615#discussion_r1557654249) | 5-bit round-to-nearest quantization (`q`). Each block has 32 weights. Weight formula: `w = q * block_scale`. Legacy quantization method (not used widely as of today). |
| Q5_1 | [GH](https://github.com/huggingface/huggingface.js/pull/615#discussion_r1557682290) | 5-bit round-to-nearest quantization (`q`). Each block has 32 weights. Weight formula: `w = q * block_scale + block_minimum`. Legacy quantization method (not used widely as of today). |
| Q5_K | [GH](https://github.com/ggerganov/llama.cpp/pull/1684#issue-1739619305) | 5-bit quantization (`q`). Super-blocks with 8 blocks, each block has 32 weights. Weight formula: `w = q * block_scale(6-bit) + block_min(6-bit)`, resulting in 5.5 bits-per-weight. |
| Q4_0 | [GH](https://github.com/huggingface/huggingface.js/pull/615#discussion_r1557654249) | 4-bit round-to-nearest quantization (`q`). Each block has 32 weights. Weight formula: `w = q * block_scale`. Legacy quantization method (not used widely as of today). |
| Q4_1 | [GH](https://github.com/huggingface/huggingface.js/pull/615#discussion_r1557682290) | 4-bit round-to-nearest quantization (`q`). Each block has 32 weights. Weight formula: `w = q * block_scale + block_minimum`. Legacy quantization method (not used widely as of today). |
| Q4_K | [GH](https://github.com/ggerganov/llama.cpp/pull/1684#issue-1739619305) | 4-bit quantization (`q`). Super-blocks with 8 blocks, each block has 32 weights. Weight formula: `w = q * block_scale(6-bit) + block_min(6-bit)`, resulting in 4.5 bits-per-weight. |
| Q3_K | [GH](https://github.com/ggerganov/llama.cpp/pull/1684#issue-1739619305) | 3-bit quantization (`q`). Super-blocks with 16 blocks, each block has 16 weights. Weight formula: `w = q * block_scale(6-bit)`, resulting. 3.4375 bits-per-weight. |
| Q2_K | [GH](https://github.com/ggerganov/llama.cpp/pull/1684#issue-1739619305) | 2-bit quantization (`q`). Super-blocks with 16 blocks, each block has 16 weight. Weight formula: `w = q * block_scale(4-bit) + block_min(4-bit)`, resulting in 2.5625 bits-per-weight. |
| IQ4_NL | [GH](https://github.com/ggerganov/llama.cpp/pull/5590) | 4-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`. |
| IQ4_XS | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 4-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 4.25 bits-per-weight. |
| IQ3_S | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 3-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 3.44 bits-per-weight. |
| IQ3_XXS | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 3-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 3.06 bits-per-weight. |
| IQ2_XXS | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 2-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 2.06 bits-per-weight. |
| IQ2_S | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 2-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 2.5 bits-per-weight. |
| IQ2_XS | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 2-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 2.31 bits-per-weight. |
| IQ1_S | [HF](https://huggingface.co/CISCai/OpenCodeInterpreter-DS-6.7B-SOTA-GGUF/blob/main/README.md?code=true#L59-L70) | 1-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 1.56 bits-per-weight. |
| IQ1_M | [GH](https://github.com/ggerganov/llama.cpp/pull/6302) | 1-bit quantization (`q`). Super-blocks with 256 weights. Weight `w` is obtained using `super_block_scale` & `importance matrix`, resulting in 1.75 bits-per-weight. |

## Tensor Encoding Scheme Mapping

[Source](https://github.com/ggerganov/llama.cpp/wiki/Tensor-Encoding-Schemes)

| Scheme   | Bits/Weight | Data Type                     | Block Configuration                                                                   |
| -------- | ----------- | ----------------------------- | ------------------------------------------------------------------------------------- |
| BF16     | 16          | bfloat16 (trunc 32b IEEE754)  | Homogonous Array Of Floating Weights                                                  |
| F16      | 16          | 16-bit IEEE 754               | Homogonous Array Of Floating Weights                                                  |
| F32      | 32          | 32-bit IEEE 754               | Homogonous Array Of Floating Weights                                                  |
| F64      | 64          | 64-bit IEEE 754               | Homogonous Array Of Floating Weights                                                  |
| I8       | 8           | (signed?) integer             | -                                                                                     |
| I16      | 16          | (signed?) integer             | -                                                                                     |
| I32      | 32          | (signed?) integer             | -                                                                                     |
| I64      | 64          | (signed?) integer             | -                                                                                     |
| Q4_0     | 4           | round to nearest quantization | Each block has 32 weights                                                             |
| Q4_1     | 4           | round to nearest quantization | Each block has 32 weights                                                             |
| Q4_1_F16 | 4           | round to nearest quantization | Each block has 32 weights (token embedding and output weights are F16)                |
| Q8_0     | 8           | round to nearest quantization | Each block has 32 weights                                                             |
| Q8_1     | 8           | round to nearest quantization | Each block has 32 weights                                                             |
| Q5_0     | 5           | round to nearest quantization | Each block has 32 weights                                                             |
| Q5_1     | 5           | round to nearest quantization | Each block has 32 weights                                                             |
| Q2_K     | 2.5625      | k-quantization                | Superblocks has 16 blocks ( 16 weights per block)                                     |
| Q3_K     | 3.4375      | k-quantization                | Superblocks has 16 blocks ( 16 weights per block)                                     |
| Q4_K     | 4.5         | k-quantization                | Superblocks has  8 blocks ( 32 weights per block)                                     |
| Q5_K     | 5.5         | k-quantization                | Superblocks has  8 blocks ( 32 weights per block)                                     |
| Q6_K     | 6.5625      | k-quantization                | Superblocks has 16 blocks ( 16 weights per block)                                     |
| Q8_K     | 8.0         | k-quantization                | Superblocks has  1 blocks (256 weights per block) (Only used for intermediate quants) |
| IQ1_S    | 1.5         | i-quantization                | Superblocks has  8 blocks ( 32 weights per block)                                     |
| IQ1_M    | 1.75        | i-quantization                | Superblocks has 16 blocks ( 16 weights per block)                                     |
| IQ2_XXS  | 2.0625      | i-quantization                | Superblocks has  8 blocks ( 32 weights per block)                                     |
| IQ2_XS   | 2.31        | i-quantization                | Superblocks has 16 blocks ( 16 weights per block)                                     |
| IQ2_S    | 2.5         | i-quantization                | ?                                                                                     |
| IQ3_S    | 3.4375      | i-quantization                | ?                                                                                     |
| IQ3_XXS  | 3.0625      | i-quantization                | Superblocks has  8 blocks ( 32 weights per block)                                     |
| IQ4_NL   | 4.5         | i-quantization                | Superblocks has 16 blocks ( 16 weights per block)                                     |
| IQ4_XS   | 4.25        | i-quantization                | Superblocks has  8 blocks ( 32 weights per block)                                     |

## Credits

- [TheBloke](https://huggingface.co/TheBloke) - Inspiration. Influence. Information on quantization methods, ideas and more.
- Dampf, [Turboderp](https://github.com/turboderp) and [Kalomaze](https://github.com/kalomaze) - For contributing to the calibration datasets.
- [Bartowski](https://github.com/bartowski1182) - For the calibration datasets, information on quantization methods and more.
- [Artefact2](https://github.com/Artefact2) - For scripts, guides, information and more.
- [llama.cpp](https://github.com/ggerganov/llama.cpp) - Various information, source code and more.
