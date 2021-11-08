module Main where

import Data.Maybe
import Prelude

import CSS.Background as CB
import Color as C
import Effect (Effect)
import Effect.Aff.Class (class MonadAff)
import HTML.RawHTML (unsafeSetInnerHTML)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.CSS as HC
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)
import Markdownit.Markdownit (markdownIt)
import Partial.Unsafe (unsafePartial)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body

type State = {
  html :: String,
  textarea :: String,
  output :: H.RefLabel
  }

data Action = OnValueChange String

component :: forall query input output m. MonadAff m => H.Component query input output m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval { handleAction = handleAction }
    }

initialState :: forall input. input -> State
initialState _ = {
  html: "<h1>hello</h1>",
  textarea: "# hello",
  output: H.RefLabel "output"
  }

render :: forall m. State -> H.ComponentHTML Action () m
render state = do
  HH.div_ [
        HH.h1 [ HP.id "title" ] [ HH.text "Markdown Editor written in Purescript" ],
        HH.textarea [ HE.onValueInput \s -> OnValueChange s, HP.value state.textarea],
        HH.p [] [ HH.text $ show state.textarea ],
        HH.p [] [ HH.text $ show state.html ],
        HH.div [ HP.ref state.output,
                 HP.id "output", 
                 HP.class_ (H.ClassName "markdown-body"), 
                 HC.style do 
                    CB.backgroundColor white
               ] []
        --HH.script [ HP.src "https://cdnjs.cloudflare.com/ajax/libs/markdown-it/12.2.0/markdown-it.js" ] []
        ]
    where 
        white = C.rgb 212 212 212

handleAction :: forall output m. MonadAff m => Action -> H.HalogenM State Action () output m Unit
handleAction = case _ of
  OnValueChange value -> do
     { output } <- H.get
     div <- H.getHTMLElementRef output
     case div of
          Just _ -> do
             H.liftEffect $ unsafeSetInnerHTML (unsafePartial (fromJust div)) (markdownIt value)
             H.modify_ _ { textarea = value, html = markdownIt value, output = output }
          Nothing ->
             H.modify_ _ { textarea = value, html = markdownIt value, output = H.RefLabel "output" }
