module Markdown.MDParser where

import Prelude

import Control.Alt ((<|>))
import Control.Monad (class Monad)
import Data.Eq (class Eq)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep (class Generic)
import Data.List (List, many, (:), length, foldr)
import Data.List.Lazy (nil, replicate)
import Data.List.Types (toList, NonEmptyList)
import Data.Map.Internal as M
import Data.Maybe (Maybe, isJust)
import Data.Tuple (Tuple)
import Text.Parsing.StringParser as P
import Text.Parsing.StringParser.Combinators as PSC
import Text.Parsing.StringParser.CodePoints as PSCP
import Web.DOM.Document (doctype)

-- type define

data Document = Document (List Block) (List MetaData)
derive instance Eq Document
derive instance Generic Document _

-- data ListItem = ListLineItem Int (List Inline) (List ListItem)
--               | ListParaItem Int (List Block) (List ListItem)
-- derive instance Eq ListItem
-- derive instance Generic ListItem _

data Block = Header Int (List Inline)
           | BlockHtml (List Inline)
           | HorizontalRule
           -- | List ListItem
           | CodeBlock (List Inline)
           | BlockQuote (List Block)
           | Paragraph (List Inline)
           | NullB
derive instance eqBlock :: Eq Block

data Inline = LineBreak
            | SoftBreak
            | Space
            | Strong (List Inline)
            | Emphasis (List Inline)
            | InlineLink String String (Maybe String)
            | ReferenceLink String RefId
            | InlineCode (List Inline)
            | InlineHtml (List Inline)
            | Str String
            | NullL
derive instance eqInline :: Eq Inline

type RefId    = String
type RefLink  = String
type RefTitle = Maybe String
data MetaData = MetaData { references :: M.Map RefId (Tuple RefLink RefTitle) -- info of reference links
                         , doesFormatHtml :: Boolean -- should format a converted html?
                           }
derive instance Eq MetaData
derive instance Generic MetaData _


data ParseContext = ParseContext { metadata :: MetaData -- meta data of document
                                 , lineStart :: Char -- character at the start of line
                                 , isLastNewLineQuoted :: Boolean -- last newline is quoted?
                                 , quoteLevel :: Int -- depth of the current quote block
                                 }

-- pHeader :: P.Parser Int
-- pHeader = do 
--   symbol <- length <$> PSC.many $ PSCP.char '#'
--   pure symbol



-- attributeParser :: Parser HtmlAttribute
-- attributeParser = do
--   k <- regex "[^=>/ ]+"
--   void whiteSpace
--   v <- option "" (equals *> quotedString)
--   pure $ HtmlAttribute k v
-- 
-- pHeader = P.try $ do
--   level <- length <$> P.many1 (P.char '#')
--   skipSpaces
--   inlines <- P.many1 (P.notFollowedBy blanklines >> parser)
--   blanklinesBetweenBlock
--   return $ Header level inlines
