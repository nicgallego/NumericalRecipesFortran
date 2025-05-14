![CI Status](https://github.com/nicgallego/NumericalRecipesFortran/actions/workflows/ci.yml/badge.svg)

# Numerical Recipes in Fortran

Didactic implementation by Nicolas Gallego

Basically, my goal is to take appart the code of this book and put it back togeter for didactical purposes, including
- experience with old/new fortran styles
- doxygen documentation for fortran
- practice a build system 
- collect information in the book and in the repos found to run the routines inside a test harness
- test different test drivers, like vegetables or something pure fortran, light weight.

A long way to go, nice goals to near and enjoy on my 'tiempo desocupado'

## How to use this code

You need meson>=0.5, and a fortran compiler, currently tested on gfortran 13.3.0 on ubuntu 24.04. There is an internal dependency on test-drive, that should be fetched from the internet automatically while configuring the project. The documentation contains math expressions, I activated USE_MATHJAX in Doxygen settings, so that no need for sometims hard to setup latex is needed. 

Configure the project with:
```
meson setup <build-folder> <source-folder>
```

Compile it with:
```
meson compile -C <build-folder>
```

Run the tests with:
```
meson test -C <build-folder>
```
I often use -v for verbose or even --print-errorlogs

Finally, a special type of tests are benchmarks, call the benchmarks with:
```
meson test -C <build-folder> --benchmark
```
with -v flag prints the output on standard output.

The project is also documented using Doxygen comment blocks, the documentation can be generated using
```
meson compile doc -C <build-folder>
```
then open it with
```
open <build-folder>/doc/html/index.html
```

An online version of the project documentation is hosted [here](https://nicgallego.github.io/NumericalRecipesFortran/).
