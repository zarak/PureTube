module Components.VideoDetail where

import Prelude
import Apis.YouTube (Item)
import Data.Maybe (Maybe(..))
import React.Basic (JSX, empty)
import React.Basic.DOM as R

type Props
  = { video :: Maybe Item
    }

videoDetail :: Props -> JSX
videoDetail { video } = case video of
  Nothing -> empty
  Just v ->
    R.div_
      [ R.div
          { className: "ui embed"
          , children:
              [ R.iframe
                  { title: "Video Player"
                  , src: videoSrc
                  }
              ]
          }
      , R.div
          { className: "ui segment"
          , children:
              [ R.h4
                  { className: "ui header"
                  , children:
                      [ R.text v.snippet.title ]
                  }
              , R.p_ [ R.text v.snippet.description ]
              ]
          }
      ]
    where
    videoSrc = "https://www.youtube.com/embed/" <> v.id.videoId
