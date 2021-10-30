module Main where

import Prelude

import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)

import Markdownit.Markdownit (markdownIt)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body

type State = {
  html :: String,
  textarea :: String
  }

data Action = OnValueChange String

component :: forall query input output m. H.Component query input output m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval { handleAction = handleAction }
    }

initialState :: forall input. input -> State
initialState _ = {
  html: "",
  textarea: "# hello"
  }

render :: forall m. State -> H.ComponentHTML Action () m
render state = do
  HH.div_
    [
      HH.h1 [ HP.id "title" ] [ HH.text "Markdown Editor written in Purescript" ],
      HH.textarea [ HE.onValueInput \s -> OnValueChange s, HP.value state.textarea],
      HH.p [] [ HH.text $ show state.textarea ],
      HH.p [] [ HH.text $ show state.html ]
      -- HH.div [ HP.id "output" ] [ HH.text state.html ]
    ]

handleAction :: forall output m. Action -> H.HalogenM State Action () output m Unit
handleAction = case _ of
  OnValueChange value -> do
     H.modify_ _ { textarea = value, html = markdownIt value }
