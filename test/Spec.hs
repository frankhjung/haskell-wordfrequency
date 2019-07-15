module Main(main) where

import           WordFrequency

import           Data.Char     (toLower)
import           Data.List     (sort)
import           Test.Hspec    (context, describe, hspec, it, shouldBe)

main :: IO ()
main = hspec $ do

  describe "map toLower" $
    context "when string has uppercase character" $
      it "returns with lowercase characters" $
        map toLower "HELLO World" `shouldBe` "hello world"

  describe "words . map toLower" $
    context "when string containing words" $
      it "returns list of lowercase words" $
        words (map toLower "HELLO World") `shouldBe` ["hello", "world"]

  describe "sort . words . map toLower" $
    context "when string containing words" $
      it "returns sorted list of lowercase words" $
        sort (words (map toLower "World HELLO")) `shouldBe` ["hello", "world"]

  describe "countRuns" $ do
    context "when 1 x hello" $
      it "returns tuple (1,hello)" $
        countRuns ["hello", "world", "world"] `shouldBe` [(1, "hello"), (2, "world")]
    context "when 2 x hello" $
      it "returns tuple (2,hello)" $
        countRuns ["hello", "hello", "world"] `shouldBe` [(2, "hello"), (1, "world")]

  describe "countRuns'" $ do
    context "when 1 x hello" $
      it "returns tuple (1,hello)" $
        countRuns' ["hello", "world", "world"] `shouldBe` [(1, "hello"), (2, "world")]
    context "when 2 x hello" $
      it "returns tuple (2,hello)" $
        countRuns' ["hello", "hello", "world"] `shouldBe` [(2, "hello"), (1, "world")]

  describe "sortRuns" $ do
    context "when hello appears twice" $
      it "returns hello first" $
        sortRuns [(2,"hello"), (1,"world")] `shouldBe` [(2, "hello"), (1, "world")]
    context "when hello appears once" $
      it "returns hello last" $
        sortRuns [(1,"hello"), (2,"world")] `shouldBe` [(2, "world"), (1, "hello")]

  describe "sortRuns'" $ do
    context "when hello appears twice" $
      it "returns hello first" $
        sortRuns' [(2,"hello"), (1,"world")] `shouldBe` [(2, "hello"), (1, "world")]
    context "when hello appears once" $
      it "returns hello last" $
        sortRuns' [(1,"hello"), (2,"world")] `shouldBe` [(2, "world"), (1, "hello")]

  describe "showRuns" $
    context "when tuple (1,hello)" $
      it "returns string '1\\thello\\n" $
        showRun (1,"hello") `shouldBe` "1\thello\n"

  describe "commonWords" $
    context "when given list of words" $
      it "returns words in descending frequency" $
        commonWords "HELLO World hello Hello" `shouldBe` "3\thello\n1\tworld\n"

