module Components.VideoItem where

import Prelude
import Apis.YouTube (Item)
import Effect (Effect)
import React.Basic (JSX)
import React.Basic.DOM as R
import React.Basic.Events (handler_)

type Props
  = { video :: Item
    , onVideoSelect :: Item -> Effect Unit
    , key :: String
    }

videoItem :: Props -> JSX
videoItem props =
  R.div
    { className: "video-item item"
    , onClick:
        handler_ $ props.onVideoSelect props.video
    , children:
        [ R.img
            { className: "ui image"
            , alt: props.video.snippet.title
            , src: props.video.snippet.thumbnails.medium.url
            }
        , R.div
            { className: "content"
            , children:
                [ R.div
                    { className: "header"
                    , children: [ R.text props.video.snippet.title ]
                    }
                ]
            }
        ]
    }
