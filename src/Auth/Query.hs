{-# LANGUAGE OverloadedStrings            #-}
{-# LANGUAGE QuasiQuotes                  #-}

module Auth.Query (allRoles, createUserWithRole) where

import           Database.PostgreSQL.Simple (Query)
import           Database.PostgreSQL.Simple.SqlQQ

allRoles :: Query
allRoles = [sql| SELECT name FROM role ORDER BY name |]

createUserWithRole :: Query
createUserWithRole = [sql|
  INSERT INTO snap_auth_user (login, first_name, last_name, login_count, failed_login_count, role, password)
  VALUES (?,?,?,?,?,?,?)
  RETURNING login
  |]


