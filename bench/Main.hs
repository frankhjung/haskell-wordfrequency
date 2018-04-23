module Main(main) where

import           Criterion.Main (bench, bgroup, defaultMain, nf)
import           WordFrequency  (countRuns, countRuns', sortRuns, sortRuns')

main :: IO ()
main = defaultMain
  [
    bgroup "countRuns"
    [
      bench "countRuns" $ nf countRuns ["hello", "world", "world"]
    , bench "countRuns'" $ nf countRuns' ["hello", "world", "world"]
    ],
    bgroup "sortRuns"
    [
      bench "sortRuns" $ nf sortRuns [(2,"hello"), (1,"world")]
    , bench "sortRuns'" $ nf sortRuns' [(2,"hello"), (1,"world")]
    ]
  ]

