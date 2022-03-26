module Components.VideoList where

import Prelude
import Apis.YouTube (Item)
import Components.VideoItem (videoItem)
import Effect (Effect)
import React.Basic (JSX)
import React.Basic.DOM as R

type Props
  = { videos :: Array Item
    , onVideoSelect :: Item -> Effect Unit
    }

videoList :: Props -> JSX
videoList props =
  let
    renderVideo :: Item -> JSX
    renderVideo video =
      videoItem
        { key: video.id.videoId
        , onVideoSelect: props.onVideoSelect
        , video: video
        }
  in
    R.div
      { className: "ui relaxed divided list"
      , children: renderVideo <$> props.videos
      }
