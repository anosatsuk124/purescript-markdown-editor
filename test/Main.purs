module Test.Main where

import Prelude

import Data.Array as Array
import Data.String.CodeUnits (fromCharArray)
import Effect (Effect)
import Effect.Class.Console (log)
import Data.List

main :: Effect Unit
main = do
  log $ charListToString ['a', 'c']
  log $ charListToString1 ['a', 'c']

charListToString :: Array Char -> String
charListToString = fromCharArray <<< Array.fromFoldable

charListToString1 :: Array Char -> String
charListToString1 a = fromCharArray $ Array.fromFoldable a
