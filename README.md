# Haskell - Word Frequency

An Implementation of Word Frequency problem as described in
[Thinking Functionally with Haskell](https://doi.org/10.1017/CBO9781316092415)
by Richard Bird.

## Build

Using GNU Make build project with:

```bash
make clean setup default
```

To run the full suite (check, build, test, doc, bench, exec):

```bash
make all
```

## Run

To run an example of `wordfrequency`:

```bash
make exec
```

## Updating GHC / LTS Version

When upgrading to a new GHC or Stackage LTS snapshot,
update the following files:

| File                              | What to change                     |
| --------------------------------- | ---------------------------------- |
| `cabal.project`                   | Update the LTS import URL          |
| `wordfrequency.cabal`             | Update `tested-with` and bounds    |
| `.github/workflows/haskell.yml`   | Update `ghc-version`               |
| `.gitlab-ci.yml`                  | Update Docker image tag            |

For example, to upgrade from LTS 22.44 to a newer LTS:

1. Find the new snapshot at
   [stackage.org](https://www.stackage.org)

2. In `cabal.project`, change the import URL:

   ```cabal
   import: https://www.stackage.org/lts-XX.YY/cabal.config
   ```

3. In `wordfrequency.cabal`, update:

   ```cabal
   tested-with: GHC == X.Y.Z
   ```

4. In `.github/workflows/haskell.yml`, update:

   ```yaml
   ghc-version: 'X.Y.Z'
   ```

5. In `.gitlab-ci.yml`, update the image:

   ```yaml
   image:
     name: haskell:X.Y.Z
   ```
