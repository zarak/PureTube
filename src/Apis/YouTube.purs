module Apis.YouTube where

import Prelude
import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Data.Either (Either(..))
import Effect.Aff (Aff)

-- TODO: Use proper URL builder
type YoutubeVideoResult
  = { kind :: String
    , etag :: String
    , nextPageToken :: String
    , regionCode :: String
    , pageInfo :: PageInfo
    , items :: Array Item
    }

type Item
  = { kind :: String
    , etag :: String
    , id :: ID
    , snippet :: Snippet
    }

type Snippet
  = { publishedAt :: String
    , channelId :: String
    , title :: String
    , description :: String
    , thumbnails :: Thumbnails
    , channelTitle :: String
    , liveBroadcastContent :: String
    , publishTime :: String
    }

type ID
  = { kind :: String
    , videoId :: String
    }

type Thumbnails
  = { default :: Default
    , medium :: Default
    , high :: Default
    }

type Default
  = { url :: String
    , width :: Number
    , height :: Number
    }

type PageInfo
  = { totalResults :: Number
    , resultsPerPage :: Number
    }

youtubeApiKey :: String
youtubeApiKey = "AIzaSyBDJBBd7eJByDPi_n2q3Lk-2O1uZuO15l0"

baseUrl :: String
baseUrl = "https://www.googleapis.com/youtube/v3/search"

params :: String
params = "?part=snippet&maxResult=5&key=" <> youtubeApiKey

fullUrl :: String
fullUrl = baseUrl <> params

searchUrl :: String -> Aff String
searchUrl term = do
  result <- AX.get ResponseFormat.string $ fullUrl <> "&q=" <> term
  pure case result of
    Left err -> "GET /api response failed to decode: " <> AX.printError err
    Right response -> response.body
