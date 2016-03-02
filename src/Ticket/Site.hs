{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE RecordWildCards   #-}

module Ticket.Site
  ( routes
  ) where

import           Data.ByteString               (ByteString)
import           Data.ByteString.Char8         (unpack)
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.PostgresqlSimple (Only (..), execute, query,
                                                query_)
import           Text.Read

import           Application
import           Data.Aeson                    (decode')
import           Layout                        (renderWithLayout)
import           Ticket.Query                  (allClients, allProductAreas,
                                                allTickets, createTicket,
                                                ticketById, updateTicket)
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

update :: Handler App (AuthManager App) ()
update = do
  ticketObject <- readRequestBody tenKBytes
  let maybeTicket = (decode' ticketObject :: Maybe Ticket)
  case maybeTicket of
    Nothing           -> modifyResponse $ setResponseStatus 400 "Bad Data"
    Just ticket -> do
      execute updateTicket ticket
      modifyResponse $ setResponseStatus 200 "Successfully Updated Ticket"
  where
    tenKBytes = 10 * 1000

edit :: Handler App (AuthManager App) ()
edit = do
  maybeTicketIdParam <- getParam "ticketId"
  case (maybeTicketIdParam >>= readMaybe . unpack) of
    Nothing            -> modifyResponse $ setResponseStatus 400 "Invalid Request Parameter"
    Just ticketIdParam -> do
      [ticket]      <- query ticketById (Only (ticketIdParam :: Int))
      clients       <- query_ allClients
      productAreas  <- query_ allProductAreas
      renderWithLayout $ ticketForm clients productAreas (Just ticket)

routes :: [(ByteString, Handler App App ())]
routes = [ ("/tickets/index", with auth index)
         , ("/tickets/new", with auth new)
         , ("/tickets/create", with auth create)
         , ("/tickets/:ticketId/edit", with auth edit)
         , ("/tickets/update", with auth update)
         ]
