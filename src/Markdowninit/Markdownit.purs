module Markdownit.Markdownit where

import Markdownit.Types (Application, Markdown)
import Effect (Effect)

foreign import markdownit :: Effect Application

foreign import render :: Application -> Markdown -> String
