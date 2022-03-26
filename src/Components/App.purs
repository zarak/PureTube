module App where

import Prelude
import Apis.YouTube (Item, YoutubeVideoResult, searchUrl)
import Components.SearchBar (defaultSearchTerm, mkSearchBar)
import Components.VideoDetail (videoDetail)
import Components.VideoList (videoList)
import Data.Array (head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import React.Basic.DOM as R
import React.Basic.Hooks (Component, component, useEffectOnce, useState)
import React.Basic.Hooks as Hooks
import Simple.JSON (readJSON)

mkApp :: Component Unit
mkApp = do
  searchBar <- mkSearchBar
  component "App" \_ -> Hooks.do
    videos /\ setVideos <- useState ([] :: Array Item)
    selectedVideo /\ setSelectedVideo <- useState (Nothing :: Maybe Item)
    let
      onTermSubmit term =
        launchAff_ do
          res <- searchUrl term
          log res
          case readJSON res of
            Right (r :: YoutubeVideoResult) -> do
              liftEffect $ setVideos $ const r.items
              case head r.items of
                Just x -> liftEffect $ setSelectedVideo $ const (Just x)
                Nothing -> log $ "Nothing"
            Left e -> do
              log $ "Can't parse JSON. " <> show e
    useEffectOnce do
      onTermSubmit defaultSearchTerm
      -- Monadic value is cleanup
      pure $ log "Initial submit"
    pure do
      R.div
        { className: "ui container"
        , children:
            [ searchBar { onFormSubmit: onTermSubmit }
            , R.div
                { className: "ui grid"
                , children:
                    [ R.div
                        { className: "ui row"
                        , children:
                            [ R.div
                                { className: "eleven wide column"
                                , children:
                                    [ videoDetail { video: selectedVideo } ]
                                }
                            , R.div
                                { className: "five wide column"
                                , children:
                                    [ videoList
                                        { onVideoSelect:
                                            \i ->
                                              setSelectedVideo $ const (Just i)
                                        , videos: videos
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }
