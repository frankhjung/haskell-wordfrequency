module WordFrequency ( countRuns
                     , sortRuns
                     , showRun
                     , commonWords
                     ) where

import           Data.Char (toLower)
import           Data.List (sort, sortBy)
import           Data.Ord  (Down (..), comparing)

commonWords :: String -> String
commonWords = concatMap showRun . sortRuns . countRuns . sort . words . map toLower

countRuns :: [String] -> [(Int, String)]
countRuns [] = []
countRuns (x:xs) = (a,x) : countRuns (filter (/=x) xs)
  where a = length $ filter (==x) (x:xs)

sortRuns :: [(Int, String)] -> [(Int, String)]
sortRuns = sortBy (comparing (Down . fst))

showRun :: (Int, String) -> String
showRun (i,s) = show i ++ "\t" ++ s ++ "\n"

