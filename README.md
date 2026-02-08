# RISC-V Audiomark - Task 


This repository contains an optimized C implementation of the following operation using RISC-V Vector intrinsics:

`void q15_axpy_rvv(const int16_t *a, const int16_t *b, int16_t *y, int n, int16_t alpha);`

## Implementation Overview

### Scalar Reference
The base implementation performs standard integer arithmetic:
*   Multiplies the scalar `alpha` by vector `b`.
*   Adds the result to vector `a`.
*   Clips the final value to fit within the signed 16-bit range (Q15).

### RVV Implementation
The vectorized version utilizes the following features:
*   **vsetvl**: Dynamic vector length configuration for hardware independence.
*   **vle16.v**: Efficient 16-bit vector loading.
*   **vwmul.vx**: Widening multiplication (16-bit to 32-bit) to preserve precision.
*   **vwadd.wv**: Widening addition into 32-bit accumulators.
*   **vnclip.wx**: Narrowing back to 16-bit with integrated saturation and rounding.
*   **vse16.v**: Vectorized storage of results.

## Design Choices
*   **Widening Logic**: Used throughout the pipeline to avoid overflows during the multiply-add stages.
*   **Single-Instruction Saturation**: Leveraging `vnclip` ensures the result exactly matches the scalar reference's saturation logic.
*   **VLEN Agnostic**: The code does not do assumption, making it portable across different processors.


## Building:
```bash
make
```

## Running:
```bash
make spike
```

## Results

### Spike Simulator (Instruction Accurate)
```text
$ make spike
Cycles ref: 56833
Verify RVV: OK (max diff = 0)
Cycles RVV: 5072
```

**Speedup: 11.21x**

## Implementation link
[vector.c](https://github.com/BhuvanB404/test/blob/master/vector.c)
