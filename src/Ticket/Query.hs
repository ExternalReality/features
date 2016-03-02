{-# LANGUAGE OverloadedStrings #-}
 {-# LANGUAGE QuasiQuotes      #-}
 {-# LANGUAGE RecordWildCards  #-}

module Ticket.Query(allTickets
                   ,allClients
                   ,allProductAreas
                   ,createTicket
                   ) where

import           Database.PostgreSQL.Simple       (Query)
import           Database.PostgreSQL.Simple.SqlQQ (sql)

allTickets :: Query
allTickets = [sql| SELECT * FROM ticket |]

allClients :: Query
allClients = [sql| SELECT * FROM client |]

allProductAreas :: Query
allProductAreas = [sql| SELECT * FROM productArea |]

createTicket :: Query
createTicket = [sql|
  INSERT INTO ticket (title, description, client, priority, targetDate, ticketURL, productArea)
  VALUES (?,?,?,(SELECT COUNT(*) + 1 FROM ticket WHERE client = ?),?,?,?)
 |]
