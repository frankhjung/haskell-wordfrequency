{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

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
                     , countRuns'
                     , sortRuns
                     , sortRuns'
                     , showRun
                     , commonWords
                     ) where

import           Data.Char (toLower)
import           Data.List (sort, sortBy)
import           Data.Ord  (Down (..), comparing)

-- | Report word frequency in descending order.
commonWords :: String -> String
commonWords = concatMap showRun . sortRuns . countRuns . sort . words . map toLower

-- | Count word frequency - Richard's version.
countRuns :: [String] -> [(Int, String)]
countRuns [] = []
countRuns (w:ws) = (1+length us, w):countRuns vs
  where (us,vs) = span(==w) ws

-- | Count word frequency - my version.
countRuns' :: [String] -> [(Int, String)]
countRuns' [] = []
countRuns' (w:ws) = (1+length a,w) : countRuns' (filter (/=w) ws)
  where a = filter (==w) ws

-- | Sort word frequency in descending order - Richard's version
sortRuns :: [(Int, String)] -> [(Int, String)]
sortRuns = sortBy (flip compare)
-- sortRuns = reverse . sort

-- | Sort word frequency in descending order - my version
sortRuns' :: [(Int, String)] -> [(Int, String)]
sortRuns' = sortBy $ comparing (Down . fst)

-- | Formatted print word frequency.
showRun :: (Int, String) -> String
showRun (i,s) = concat [show i, "\t", s, "\n"]

