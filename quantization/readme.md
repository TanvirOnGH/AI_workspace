# References

- [Which GGUF is right for me? (Opinionated)](https://gist.github.com/Artefact2/b5f810600771265fc1e39442288e8ec9)
- [calibration_datav3.txt - Used for calibrating GGUF imatrix files](https://gist.github.com/bartowski1182/eb213dccb3571f863da82e99418f81e8)
- [Tensor Encoding Schemes](https://github.com/ggerganov/llama.cpp/wiki/Tensor-Encoding-Schemes)
- [llama.cpp Feature matrix](https://github.com/ggerganov/llama.cpp/wiki/Feature-matrix)

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
