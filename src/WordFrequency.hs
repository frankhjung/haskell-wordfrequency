{-|

  Module      : wordfrequency
  Description : Count word frequency.
  Copyright   : © Frank Jung, 2018
  License     : GPL-3
  Maintainer  : frankhjung@linux.com
  Stability   : experimental
  Portability : Linux

  Report word frequency in descending order.

-}

module WordFrequency ( countRuns
                     , sortRuns
                     , showRun
                     , commonWords
                     ) where

import           Data.Char (toLower)
import           Data.List (sort, sortBy)
import           Data.Ord  (Down (..), comparing)

-- | Report word frequency in descending order.
commonWords :: String -> String
commonWords = concatMap showRun . sortRuns . countRuns . sort . words . map toLower

-- | Count word frequency.
countRuns :: [String] -> [(Int, String)]
countRuns [] = []
countRuns (x:xs) = (a,x) : countRuns (filter (/=x) xs)
  where a = length $ filter (==x) (x:xs)

-- | Sort word frequency in descending order.
sortRuns :: [(Int, String)] -> [(Int, String)]
sortRuns = sortBy (comparing (Down . fst))

-- | Formatted print word frequency.
showRun :: (Int, String) -> String
showRun (i,s) = show i ++ "\t" ++ s ++ "\n"

