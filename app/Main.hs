module Main(main) where

import           System.IO     (getContents)
import           WordFrequency (commonWords)

-- read words from stdin
-- report word frequency in descending order
main :: IO ()
main = do
    text <- getContents
    putStrLn $ commonWords text
