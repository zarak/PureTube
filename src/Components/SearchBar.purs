module Components.SearchBar where

import Prelude
import Data.Maybe (fromMaybe)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Class.Console (log)
import React.Basic.DOM (input, label_)
import React.Basic.DOM as R
import React.Basic.DOM.Events (preventDefault, targetValue)
import React.Basic.Events (handler)
import React.Basic.Hooks (Component, component, useState)
import React.Basic.Hooks as Hooks

type Props
  = { onFormSubmit :: String -> Effect Unit }

defaultSearchTerm :: String
defaultSearchTerm = "buildings"

mkSearchBar :: Component Props
mkSearchBar = do
  component "SearchBar" \props -> Hooks.do
    term /\ setTerm <- useState defaultSearchTerm
    pure do
      R.div
        { className: "search-bar ui segment"
        , children:
            [ R.form
                { onSubmit:
                    handler (targetValue <<< preventDefault) \_ -> do
                      log $ "submitted term: " <> term
                      props.onFormSubmit term
                , className: "ui form"
                , children:
                    [ R.div
                        { className: "field"
                        , children:
                            [ label_ [ R.text "Video Search" ]
                            , input
                                { type: "text"
                                , value: term
                                , onChange:
                                    handler targetValue \str -> do
                                      log $ fromMaybe "" str
                                      setTerm $ const $ fromMaybe "" str
                                }
                            ]
                        }
                    ]
                }
            ]
        }
