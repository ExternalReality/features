 {-# LANGUAGE OverloadedStrings #-}
 {-# LANGUAGE QuasiQuotes       #-}

module Ticket.View.Form (ticketForm
                         ) where

import           Data.Maybe
import           Control.Monad
import           Text.Blaze.Html
import           Text.Hamlet     (shamlet)

import           Ticket.Types    (Client (..), ProductArea, Ticket (..), formatTargetDate)

ticketForm :: [Client] -> [ProductArea] -> Maybe Ticket -> Html
ticketForm clients productAreas maybeTicket = [shamlet|
 <form id="ticketForm" data-parsley-validate>
   <input type="text" name="ticketId" id="ticketId" value=#{fromMaybe 0 (join (ticketId <$> maybeTicket))} hidden>

   <label for="title">Title
   <input type="text" name="title" id="title" value=#{fromMaybe mempty (ticketTitle <$> maybeTicket)} required>

   <label for="description">Description
   <textarea name="description" id="description" form="ticketForm" required>#{fromMaybe mempty (ticketDescription <$> maybeTicket)}

   <label for="client">Client
   <select id="client" name="client">
     $forall client <- clients
       $if (Just (clientName client) == ((clientName . ticketClient) <$> maybeTicket))
          <option value=#{clientName client} selected>#{clientName client}
       $else
          <option value=#{clientName client}>#{clientName client}

   <input type="text" name="clientPriority" id="clientPriority" value=#{fromMaybe 0 ((ticketClientPriority) <$> maybeTicket)} hidden>

   <label for="targetDate">Target Date
   <input type="text" name="targetDate" id="targetDate" value=#{fromMaybe mempty ((formatTargetDate . ticketTargetDate) <$> maybeTicket)} required>

   <label for="url">URL
   <input type="text" data-parsley-type="url" name="url" id="url" value=#{fromMaybe mempty (join (ticketURL <$> maybeTicket))}>

   <label for="productArea">ProductArea
   <select type="text" name="productArea" id="productArea">
     $forall productArea <- productAreas
        $if (Just productArea == (ticketProductArea <$> maybeTicket))
          <option value=#{show productArea} selected>#{show productArea}
       $else
          <option value=#{show productArea}>#{show productArea}
   <br>
   <input type="submit" value="Submit">
|]
