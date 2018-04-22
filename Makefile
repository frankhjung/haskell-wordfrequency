#!/usr/bin/env make

# build
#	@ghc -Wall -O2 --make ${SRCS}
# run
#	@./${TARGET}
#	@stack exec -- ${TARGET}

TARGET = wordfrequency
SRCS = $(wildcard *.hs app/*.hs src/*.hs test/*.hs)
.PHONY:	all style lint check run test doc install clean cleanall

all:	style lint build test doc

style:
	@stylish-haskell -c .stylish-haskell.yaml -i ${SRCS}

lint:
	@hlint --color ${SRCS}

check:	lint style

build:	${SRCS} check
	@stack build

run:
	@cabal run

test:	build
	@stack test

doc:
	@stack haddock

install:
	@stack install --local-bin-path $(HOME)/bin ${TARGET}

clean:
	@stack clean
	@$(RM) -rf dist

cleanall: clean
	@$(RM) -rf .stack-work/

ghci:
	@stack ghci --ghci-options -Wno-type-defaults
