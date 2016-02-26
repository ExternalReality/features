 {-# LANGUAGE OverloadedStrings #-}
 {-# LANGUAGE QuasiQuotes       #-}

 module Auth.Site
   ( routes
   ) where

 import           Control.Applicative ((<|>))
 import           Data.ByteString     (ByteString)
 import           Data.Text           (Text)
 import           Snap.Core
 import           Snap.Snaplet
 import           Snap.Snaplet.Auth

 import           Application
 import           Auth.View           (loginForm)
 import           Layout              (renderWithBaseLayout)


index :: Handler App (AuthManager App) ()
index = undefined

routes :: [(ByteString, Handler App App ())]
routes = [ ("/tickets/index", with auth index) ]


