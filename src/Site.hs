{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Site
  ( app
  ) where

import           Data.ByteString (ByteString)
import           Data.Monoid
import           Snap.Snaplet
import           Snap.Snaplet.PostgresqlSimple
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Util.FileServe
import           Snap.Snaplet.Auth.Backends.PostgresqlSimple

import           Application

import qualified Auth.Site as Auth
import qualified Ticket.Site as Ticket

routes :: [(ByteString, Handler App App ())]
routes =  Auth.routes
       <> Ticket.routes
       <> [("/static",       serveDirectory "static")]

app :: SnapletInit App App
app = makeSnaplet "app" "Content Queue" Nothing $ do
  s <- nestSnaplet "sess" sess $ initCookieSessionManager "site_key.txt" "sess" (Just 3600)
  d <- nestSnaplet "db" db pgsInit
  a <- nestSnaplet "auth" auth $ initPostgresAuth sess d
  addRoutes routes
  return $ App s d a
