{-# LANGUAGE RecordWildCards      #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Auth.Types( toText
                 , buildUserWithRole
                 ) where

import           Database.PostgreSQL.Simple.FromRow
import           Database.PostgreSQL.Simple.ToRow
import           Database.PostgreSQL.Simple.ToField
import           Database.PostgreSQL.Simple.FromField
import           Snap.Snaplet.Auth
import           Data.Text
import           Data.ByteString
import           Data.Text.Encoding(decodeUtf8)

instance FromRow Role where
  fromRow = do
    roleName <- field
    return $ Role roleName

instance ToRow Role where
  toRow (Role role) = [toField role]

instance ToField Role where
  toField (Role role) = toField role

instance FromField Role where
  fromField f mb = Role <$> fromField f mb

buildUserWithRole :: Text ->  ByteString -> Role -> AuthUser
buildUserWithRole login password role =
  defAuthUser{ userLogin    = login
             , userPassword = Just $ ClearText password
             , userRoles    = [role]
             }

toText :: Role -> Text
toText (Role name) = decodeUtf8 name
