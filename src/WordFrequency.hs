module WordFrequency ( countRuns
                     , sortRuns
                     , showRun
                     , commonWords
                     ) where

import           Data.Char (toLower)
import           Data.List (sort, sortBy)
import           Data.Ord  (Down (..), comparing)

commonWords :: Int -> String -> String
commonWords n = concatMap showRun . take n . sortRuns . countRuns . sort . words . map toLower

countRuns :: [String] -> [(Int, String)]
countRuns [] = []
countRuns (x:xs) = (a,x) : countRuns (filter (/=x) xs)
  where a = length $ filter (==x) (x:xs)

sortRuns :: [(Int, String)] -> [(Int, String)]
sortRuns = sortBy (comparing (Down . fst))

showRun :: (Int, String) -> String
showRun (i,s) = s ++ "\t" ++ show i ++ "\n"

