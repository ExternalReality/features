{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Ticket.Site
  ( routes
  ) where

import           Data.ByteString               (ByteString)
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.PostgresqlSimple (query_)

import           Application
import           Layout                        (renderWithLayout)
import           Ticket.Query                  (allTickets)
import           Ticket.View                   (ticketIndexView)

index :: Handler App (AuthManager App) ()
index = do
  tickets <- query_ allTickets
  renderWithLayout $ ticketIndexView tickets

routes :: [(ByteString, Handler App App ())]
routes = [ ("/tickets/index", with auth index) ]
