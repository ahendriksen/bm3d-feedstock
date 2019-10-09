# Conda feedstock for BM3D

This repository contains a conda recipe for building the [BM3D][0]
implementation by [Marc Lebrun][1], of which an updated implementation
can be found [here][2].

This conda recipe is especially useful for binding with scientific Python
code. The BM3D library uses FFTW, which can be shadowed by MKL, the
Intel Math Kernel Library, which is often automatically included in
Numpy installations. The MKL causes the BM3D library (and a host of
other libraries depending on FFTW) to stop working, see for instance:
- https://github.com/ericmjonas/pybm3d/issues/8
- https://github.com/conda-forge/fftw-feedstock/pull/4
- https://github.com/conda-forge/pyfftw-feedstock/pull/5

Using the techniques outlined in the links above, we are able to
circumvent the issues with MKL. This BM3D recipe is thus completely
compatible with MKL, and can be used in conjunction with Python and
Numpy. For Python bindings, see [pybind_bm3d][3].

## Installation instructions

``` bash
conda install -c aahendriksen bm3d
```

## Usage

The package installs a binary executable (`bm3d`) and a library `libbm3d.so`.

### Binary
Run BM3D image denoising.

``` bash
bm3d
```


The generic way to run the code is:

``` bash
bm3d input.png sigma ImDenoised.png [ImBasic.png ] \
	-tau_2d_hard 2DtransformStep1 -useSD_hard      \
	-tau_2d_wien 2DtransformStep2 -useSD_wien      \
	-color_space ColorSpace
```
where
- cinput.png is a noisy image;
- sigma is the value of the noise;
- ImBasic.png will contain the result of the first step of the algorithm;
- ImDenoised.png will contain the final result of the algorithm;
- 2DtransformStep1: choice of the 2D transform which will be applied in the
     second step of the algorithm. You can choose the DCT transform or the
     Bior1.5 transform for the 2D transform in the step 1 (tau_2D_hard = dct or bior)
     and/or the step 2. (tau_2d_wien = dct or bior).
- useSD_hard: for the first step, users can choose if they prefer to use
     standard variation for the weighted aggregation (useSD1 = 1)
- 2DtransformStep2: choice of the 2D transform which will be applied in the
     second step of the algorithm. You can choose the DCT transform or the
     Bior1.5 transform for the 2D transform in the step 1 (tau_2D_hard = dct or bior)
     and/or the step 2. (tau_2d_wien = dct or bior).
- useSD_wien: for the second step, users can choose if they prefer to use
     standard variation for the weighted aggregation (useSD2 = 1)
- ColorSpace: choice of the color space on which the image will be applied.
     you can choose the colorspace for both steps between : rgb, yuv, ycbcr and opp.
- patch_size: overrides the default patch size
- nb_threads: specifies the number of working threads
- verbose: print additional information

Example, run

``` bash
bm3d cinput.png 10 ImDenoised.png ImBasic.png -useSD_wien -tau_2d_hard bior -tau_2d_wien dct -color_space opp
```

### From Python

Python bindings are available at [pybind_bm3d][3]

### Linking / from C++

See [pybind_bm3d][3] for an example on how to work with and link the
library from C++.

[0]: https://doi.org/10.1109/TIP.2007.901238
[1]: https://doi.org/10.5201/ipol.2012.l-bm3d
[2]: https://github.com/gfacciol/bm3d
[3]: https://github.com/ahendriksen/pybind_bm3d
