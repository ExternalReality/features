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

login :: Handler App (AuthManager App) ()
login = method GET (handleLogin Nothing) <|> handleLoginSubmit

handleLogin :: Maybe Text -> Handler App (AuthManager App) ()
handleLogin maybeAuthError = renderWithBaseLayout $ loginForm maybeAuthError

handleLoginSubmit :: Handler App (AuthManager App) ()
handleLoginSubmit = method POST $
    loginUser "login" "password" Nothing
              (\_ -> handleLogin err) (redirect "/tickets/index")
  where
    err = Just "Unknown user or password"

handleLogout :: Handler App (AuthManager App) ()
handleLogout = logout >> redirect "/"

routes :: [(ByteString, Handler App App ())]
routes = [ ("/", with auth login)
         , ("/logout", with auth handleLogout)
         ]
