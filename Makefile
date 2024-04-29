
VERSION := 1.0
GIT_COMMIT := $(shell git rev-parse HEAD)

DOC_NAME := example-john-doe
OUT_DIR := out

SKIP_DOCKER := false

ifneq ($(SKIP_DOCKER),true)
	DOCKER_IMAGE := local/pdflatex
	DOCKER_ARGS ?= -v "$(PWD)":/opt/latex -w /opt/latex

	PDFLATEX = docker run --rm --user $(shell id -u):$(shell id -g) \
		$(DOCKER_ARGS) $(DOCKER_IMAGE) pdflatex
else
	PDFLATEX := pdflatex
endif

.PHONY: help
help:
	@echo
	@echo 'Usage:'
	@echo '    make pdf             Build the pdf.'
	@echo '    make package         Build docker image with LaTex packages inside.'
	@echo '    make clean           Clean the directory tree.'
	@echo

.PHONY: package
package:
	@echo "building image $(VERSION) $(GIT_COMMIT)"
	@docker build --build-arg VERSION=$(VERSION) --build-arg GIT_COMMIT=$(GIT_COMMIT) \
		-t $(DOCKER_IMAGE) .

define pdflatex
	@mkdir -p ${OUT_DIR}
	${PDFLATEX} $2 -synctex=1 -shell-escape -interaction=nonstopmode \
		-file-line-error -output-directory=${OUT_DIR} "$1" >/dev/null
endef

.PRECIOUS: ${OUT_DIR}/%.aux
${OUT_DIR}/%.aux: %.tex
	@echo "building $@"
	$(call pdflatex,$<,-draftmode)

${OUT_DIR}/%.pdf: %.tex ${OUT_DIR}/%.aux
	@echo "building $@"
	$(call pdflatex,$<)

.PHONY: pdf
pdf: ${OUT_DIR}/${DOC_NAME}.pdf

.PHONY: clean
clean:
	@test ! -e $(OUT_DIR) || rm -rf $(OUT_DIR)
