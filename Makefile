#!/usr/bin/env make

.PHONY:	build check format tags style-check lint test exec bench \
	doc install setup ghci clean help

TARGET	:= wordfrequency
SRCS	:= $(wildcard *.hs */*.hs)

default: preen check build test

help:
	@echo "Available targets:"
	@echo "  default      - Run preen, check, build, and test"
	@echo "  all          - Run check, build, test, doc, bench, and exec"
	@echo "  check        - Run format-check and lint"
	@echo "  preen        - Run tags and format"
	@echo "  tags         - Generate ctags for source files"
	@echo "  format       - Format source files with ormolu"
	@echo "  format-check - Check formatting with ormolu"
	@echo "  lint         - Run hlint on source files"
	@echo "  build        - Build all targets with cabal"
	@echo "  test         - Run all tests"
	@echo "  exec         - Run main executable with sample input"
	@echo "  bench        - Run benchmarks and generate HTML report"
	@echo "  doc          - Generate Haddock documentation"
	@echo "  install      - Install executable to ~/.local/bin"
	@echo "  setup        - Update cabal and build dependencies"
	@echo "  ghci         - Start GHCi REPL"
	@echo "  clean        - Clean build artifacts"

all:	check build test doc bench exec

check:	format-check lint

preen:  tags format

tags:
	@echo tags ...
	@hasktags --ctags --extendedctag $(SRCS)

format:
	@echo format ...
	@ormolu --mode inplace $(SRCS)

format-check:
	@echo format-check ...
	@ormolu --mode check $(SRCS)

lint:
	@echo lint ...
	@hlint --color $(SRCS)

build:
	@echo build ...
	@cabal build

test:
	@cabal test --test-show-details=direct

exec:
	@cabal run $(TARGET) -- +RTS -s -RTS < LICENSE

bench:
	@mkdir -p public
	@cabal bench --benchmark-options '-o public/benchmark.html'

doc:
	@mkdir -p public
	@cabal haddock lib:$(TARGET) \
		--haddock-html-location \
		'https://hackage.haskell.org/package/$$pkg-$$version/docs'
	@cp -pr $$(find dist-newstyle -type d \
		-path '*/doc/html/$(TARGET)')/. public/

install:
	@cabal install --install-method=copy \
		--overwrite-policy=always \
		--installdir=$(HOME)/.local/bin

setup:
	cabal update
	cabal build all --only-dependencies
	cabal list-bin $(TARGET)

ghci:
	@cabal repl --ghc-options -Wno-type-defaults

clean:
	@cabal clean
	@$(RM) -rf $(TARGET).tix .hdevtools.sock public
