{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}
{-# OPTIONS_GHC -fsimpl-tick-factor=1000  #-}

module Ticket.Query(allTickets
                   ,allClients
                   ,allProductAreas
                   ,createTicket
                   ,ticketById
                   ,updateTicket
                   ,deleteTicket
                   ) where

import           Database.PostgreSQL.Simple       (Query)
import           Database.PostgreSQL.Simple.SqlQQ (sql)

allTickets :: Query
allTickets = [sql| SELECT * FROM ticket ORDER BY priority |]

allClients :: Query
allClients = [sql| SELECT * FROM client |]

allProductAreas :: Query
allProductAreas = [sql| SELECT * FROM productArea |]

createTicket :: Query
createTicket = [sql|
  INSERT INTO ticket (title, description, client, priority, targetDate, ticketURL, productArea)
  VALUES (?,?,?,(SELECT COUNT(*) + 1 FROM ticket WHERE client = ?),?,?,?)
|]

deleteTicket :: Query
deleteTicket = [sql|
  WITH deleted_ticket AS (
    DELETE FROM ticket
    WHERE id = ?
    RETURNING *
  )
  UPDATE ticket
  SET priority = priority - 1
  WHERE priority > (SELECT priority FROM deleted_ticket)
  AND client IN (SELECT client FROM deleted_ticket)
|]

updateTicket :: Query
updateTicket =
  [sql| UPDATE ticket
        SET (title, description, client, priority, targetDate, ticketURL, productArea) = (?,?,?,?,?,?,?)
        WHERE id = ? |]

ticketById :: Query
ticketById = [sql| SELECT * FROM ticket WHERE id = ? |]
