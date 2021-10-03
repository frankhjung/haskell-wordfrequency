#!/usr/bin/env make

.PHONY: build check tags style lint test exec bench doc install setup ghci clean cleanall


TARGET	:= wordfrequency
SRCS	:= $(wildcard *.hs */*.hs)

default: check build test

all:	check build test doc bench exec

check:	tags style lint

tags:
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRCS)

style:
	@echo style ...
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)

lint:
	@echo lint ...
	@hlint --color $(SRCS)

build:
	@echo build ...
	@stack build --no-test

test:
	@stack test

exec:
	@stack exec -- $(TARGET) < LICENSE +RTS -s

bench:
	@stack bench --benchmark-arguments '-o .stack-work/benchmark.html'

doc:
	@stack haddock

install:
	@stack install --local-bin-path $(HOME)/bin
	-cp -pr .stack-work/benchmark.html doc/
	-cp -pr $(shell find .stack-work/install -type d -name hpc) doc/
	-cp -pr $(shell find .stack-work/dist -type d -name html) doc/

setup:
	-stack setup
	-stack build --dependencies-only --test --no-run-tests
	-stack query
	-stack ls dependencies

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

clean:
	@stack clean
	@$(RM) -rf $(TARGET).tix .hdevtools.sock

cleanall: clean
	@stack clean --full
	@$(RM) -rf .stack-work/ $(TARGET)
