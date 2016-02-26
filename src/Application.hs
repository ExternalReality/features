{-# LANGUAGE TemplateHaskell              #-}
{-# LANGUAGE FlexibleInstances            #-}
{-# OPTIONS_GHC -fno-warn-missing-methods #-}
------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.PostgresqlSimple
import Snap.Snaplet.Session
import Snap.Snaplet.Auth

import Control.Monad.State (get)
import Control.Monad.Reader (local)

data App = App
    { _sess  :: Snaplet SessionManager
    , _db    :: Snaplet Postgres
    , _auth :: Snaplet (AuthManager App)
    }

makeLenses ''App

type AppHandler = Handler App App

instance HasPostgres (Handler b App) where
  getPostgresState = with db get
  setLocalPostgresState s = local (set (db . snapletValue) s)

instance HasPostgres (Handler App (AuthManager App)) where
    getPostgresState = withTop db get
