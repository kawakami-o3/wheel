import Control.Exception
import Data.Char (isSpace)
import Prelude hiding ((++), (!!), all, and, any, break, concat, concatMap,
                       drop, dropWhile, elem, filter, foldl, foldr, init,
                       last, length, lines, map, minimum, maximum, notElem,
                       or, product, reverse, scanl, scanr, span, splitAt,
                       sum, take, takeWhile, unlines, until, unwords, unzip,
                       unzip3, words, zip, zip3, zipWith, zipWith3)
import qualified Prelude ((++), concat, concatMap, map, take)
import Test.HUnit

runTests :: [Test] -> IO Counts
runTests ts = runTestTT $ TestList ts

tests :: [[Test]]
tests = [
    appendTests
  --, concatTests
  --, mapTests
  --, concatMapTests
  --, filterTests
  --, untilTests
  --, andTests
  --, orTests
  --, anyTests
  --, allTests
  --, elemTests
  --, notElemTests
  --, zipTests
  --, zip3Tests
  --, zipWithTests
  --, zipWith3Tests
  --, unlinesTests
  --, unwordsTests
  --, lastTests
  --, initTests
  --, takeTests
  --, dropTests
  --, takeWhileTests
  --, dropWhileTests
  --, indexTests
  --, sumTests
  --, productTests
  --, maximumTests
  --, minimumTests
  , lengthTests
  --, reverseTests
  --, linesTests
  --, wordsTests
  --, splitAtTests
  --, spanTests
  --, breakTests
  --, unzipTests
  --, unzip3Tests
  --, foldlTests
  --, foldrTests
  --, scanlTests
  --, scanrTests
  ]


main :: IO Counts
main = runTests $ Prelude.concat tests

assertError :: String -> a -> Assertion
assertError msg x = handleJust errorCalls (const $ return ()) $ do
    evaluate x         
    assertFailure $ msg Prelude.++ ": error not thrown"
  where
    errorCalls (ErrorCall _) = Just ()

large :: Int
large = 2 ^ 24
--------------------------------------------------------------------------------

(++) :: [a] -> [a] -> [a]
[] ++ y = y
(x:xs) ++ y = x : (xs ++ y)

appendTests :: [Test]
appendTests = Prelude.map TestCase
  [ assertEqual "[1,2] ++ [3,4]" [1,2,3,4] ([1,2] ++ [3,4])
  , assertEqual "[] ++ [1,2]" [1,2] ([] ++ [1,2])
  , assertEqual "[1,2] ++ []" [1,2] ([1,2] ++ [])
  , assertEqual "[] ++ []" ([] :: [Int]) ([] ++ [])
  ]


length :: [a] -> Int
--length [] = 0
--length (x:xs) = 1 + length xs
length = length' 0
  where
    length' :: Int -> [a] -> Int
    length' n [] = n
    length' n (x:xs) = let m = n+1 in m `seq` length' m xs

lengthTests :: [Test]
lengthTests = Prelude.map TestCase
  [ assertEqual "length [1,2,3]" 3 (length [1,2,3])
  , assertEqual "length []" 0 (length [])
  ]

