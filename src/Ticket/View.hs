{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Ticket.View (ticketIndexTable
                   ,ticketIndexView
                   ) where

import           Data.Maybe      (fromMaybe)
import           Text.Blaze.Html (Html)
import           Text.Hamlet     (shamlet)

import           Ticket.Types    (Client (..), Ticket (..), formatTargetDate)

ticketIndexView :: [Ticket] -> Html
ticketIndexView tickets = [shamlet|
  #{newTicketButton}
  #{ticketIndexTable tickets}
|]

newTicketButton :: Html
newTicketButton = [shamlet|
  <div class='row'>
    <a href="#" class="button two-columns">New Ticket
  |]

ticketIndexTable :: [Ticket] -> Html
ticketIndexTable tickets = [shamlet|
  <table class="u-full-width">
    <thead>
      <tr>
        <th> Title
        <th> Description
        <th> Client
        <th> Client Priority
        <th> Target Date
        <th> Ticket URL
        <th> Product Area
        <th> Edit
        <th> Delete
    <tbody>
      $forall ticket <- tickets
        <tr>
          <td> #{ticketTitle ticket}
          <td> #{ticketDescription ticket}
          <td> #{clientName (ticketClient ticket)}
          <td> #{ticketClientPriority ticket}
          <td> #{formatTargetDate $ ticketTargetDate ticket}
          <td> #{fromMaybe mempty (ticketURL ticket)}
          <td> #{show $ ticketProductArea ticket}
          <td> <a href="#" class="button">Edit
          <td> <a href="#" class="button">Delete
|]
