module Main where

import Prelude
import App (mkApp)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main =
  void
    $ do
        log "Anything else at all"
        app <- mkApp
        root <- getElementById "root" =<< (toNonElementParentNode <$> (document =<< window))
        case root of
          Nothing -> throw "Root element not found."
          Just c -> do
            render (app unit) c
