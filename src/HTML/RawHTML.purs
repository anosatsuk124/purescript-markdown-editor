-- | Halogen does not support writing an HTML string to the DOM. This component allows us to do this
-- | at a particular controlled HTML node.
module HTML.RawHTML where

import Prelude

import Effect (Effect)
import Web.HTML (HTMLElement)

-- | For an explanation of how to properly use the PureScript FFI with JavaScript, please see the
-- | `src/Foreign/Marked.js` file and the `Conduit.Foreign.Marked` module.
type RawHTML = String
foreign import unsafeSetInnerHTML :: HTMLElement -> RawHTML -> Effect Unit
