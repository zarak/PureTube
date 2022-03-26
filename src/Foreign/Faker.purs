module Foreign.Faker where

import Effect (Effect)

foreign import avatar :: Effect String

foreign import random :: Effect Number
