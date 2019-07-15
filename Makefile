#!/usr/bin/env make

.PHONY: build check tags style lint test exec bench doc install setup ghci clean cleanall


TARGET	:= wordfrequency
SRCS	:= $(wildcard *.hs */*.hs)

all:	check build test doc exec

check:	tags style lint

tags:
	@hasktags --ctags --extendedctag $(SRCS)

style:
	@stylish-haskell --config=.stylish-haskell.yaml --inplace $(SRCS)

lint:
	@hlint $(SRCS)

test:
	@stack test --coverage

exec:
	@stack exec -- $(TARGET) < LICENSE +RTS -s

bench:
	@stack bench --benchmark-arguments '-o .stack-work/benchmark.html'

doc:
	@stack haddock

install:
	@stack install --local-bin-path $(HOME)/bin

setup:
	-stack setup
	-stack build --dependencies-only --test --no-run-tests
	-stack query
	-stack ls dependencies

ghci:
	@stack ghci --ghci-options -Wno-type-defaults

clean:
	@stack clean
	@$(RM) -rf $(TARGET).tix

cleanall: clean
	@$(RM) -rf .stack-work/
