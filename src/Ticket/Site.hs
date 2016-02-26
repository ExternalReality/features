{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Ticket.Site
  ( routes
  ) where

-- import           Control.Applicative ((<|>))
import           Data.ByteString     (ByteString)
-- import           Data.Text           (Text)
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth

import           Application
-- import           Layout              (renderWithBaseLayout)

index :: Handler App (AuthManager App) ()
index = writeBS "Hello"

routes :: [(ByteString, Handler App App ())]
routes = [ ("/tickets/index", with auth index) ]


