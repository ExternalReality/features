{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Ticket.Query(allTickets) where

import           Database.PostgreSQL.Simple       (Query)
import           Database.PostgreSQL.Simple.SqlQQ (sql)

allTickets :: Query
allTickets = [sql| SELECT * FROM ticket |]
