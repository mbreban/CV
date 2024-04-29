# cv

## Samples

* [Joe Doe - EN](./samples/example-john-doe-en.pdf)
* [Joe Doe - FR](./samples/example-john-doe-fr.pdf)

## Getting Started

```sh
make package
```

Then build the example CV.

```sh
make pdf
```

You can define the LaTex file to be built with the `DOC_NAME` variable.

```sh
make pdf DOC_NAME=filename.tex
```

> **Note:**
> The use of the docker image can be disabled with the `SKIP_DOCKER=false` option.
> The host system must have `pdflatex` installed.

## Clear outputs

```sh
make clean
```
