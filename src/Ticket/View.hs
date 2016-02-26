{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Ticket.View (ticketIndexTable) where

-- import           Data.Text       (Text)
import           Text.Blaze.Html (Html)
import           Text.Hamlet     (shamlet)

import           Ticket.Types    (Ticket)

ticketIndexTable :: [Ticket] -> Html
ticketIndexTable tickets = [shamlet|
  <table>
    <thead>
      <th>
      <th>
      <th>
      <th>
      <th>
      <th>
      <th>
|]
