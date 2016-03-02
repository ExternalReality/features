{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}

module Ticket.Site
  ( routes
  ) where

import           Data.ByteString               (ByteString)
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.PostgresqlSimple (execute, query_)

import           Application
import           Data.Aeson                    (decode')
import           Layout                        (renderWithLayout)
import           Ticket.Query                  (allClients, allProductAreas,
                                                allTickets, createTicket)
import           Ticket.Types                  (Client (..), Ticket (..),
                                                formatTargetDate)
import           Ticket.View                   (ticketIndexView)
import           Ticket.View.Form              (ticketForm)

index :: Handler App (AuthManager App) ()
index = do
  tickets <- query_ allTickets
  renderWithLayout $ ticketIndexView tickets

new :: Handler App (AuthManager App) ()
new = do
  clients      <- query_ allClients
  productAreas <- query_ allProductAreas
  renderWithLayout $ ticketForm clients productAreas Nothing

create :: Handler App (AuthManager App) ()
create = do
  ticketObject <- readRequestBody tenKBytes
  let maybeTicket = (decode' ticketObject :: Maybe Ticket)
  case maybeTicket of
     Nothing     -> modifyResponse $ setResponseStatus 400 "Bad Data"
     Just (Ticket{..}) -> do
      execute createTicket ( ticketTitle
                           , ticketDescription
                           , clientName ticketClient
                           , clientName ticketClient
                           , formatTargetDate $ ticketTargetDate
                           , ticketURL
                           , show ticketProductArea
                           )
      modifyResponse $ setResponseStatus 200 "Successfully Created Ticket"
 where
   tenKBytes = 10 * 1000

routes :: [(ByteString, Handler App App ())]
routes = [ ("/tickets/index", with auth index)
         , ("/tickets/new", with auth new)
         , ("/tickets/create", with auth create)
         ]
