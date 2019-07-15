module Main(main) where

import           System.IO     (getContents)
import           WordFrequency (commonWords)

-- | Count word frequency. Read words from stdin and
-- report word frequency in descending order.
main :: IO ()
main = getContents >>= \text -> putStrLn (commonWords text)
