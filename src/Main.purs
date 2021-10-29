module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Markdownit.Markdownit (markdownit, render)

main :: Effect Unit
main = do
  app <- markdownit
  log $ render app "aaa"
