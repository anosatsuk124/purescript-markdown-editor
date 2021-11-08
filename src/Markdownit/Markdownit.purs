module Markdownit.Markdownit where

import Markdownit.Types (Markdown)

foreign import markdownIt :: Markdown -> String
