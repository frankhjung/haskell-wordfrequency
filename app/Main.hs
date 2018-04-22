module Main(main) where

import           WordFrequency (commonWords)

--
-- MAIN count top ten word frequency
--
main :: IO ()
main = putStrLn $ commonWords 10 "HELLO World hello Hello"
