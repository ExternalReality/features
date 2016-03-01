 {-# LANGUAGE OverloadedStrings #-}
 {-# LANGUAGE QuasiQuotes       #-}

module Ticket.Types ( Ticket(..)
                    , ProductArea(..)
                    , Client(..)
                    , formatTargetDate
                    ) where

import Data.Text (Text)
import Data.Time.Calendar (Day)
import Data.Time.Format
import Database.PostgreSQL.Simple.FromRow

data Client = Client {clientName :: Text}
  deriving (Eq, Show)

data ProductArea = Policies | Billing | Claims | Reports
  deriving (Show, Eq, Read)

data Ticket = Ticket { ticketId             :: Maybe Int
                     , ticketTitle          :: Text
                     , ticketDescription    :: Text
                     , ticketClient         :: Client
                     , ticketClientPriority :: Int
                     , ticketTargetDate     :: Day
                     , ticketURL            :: Maybe Text
                     , ticketProductArea    :: ProductArea
                     } deriving (Eq, Show)

instance FromRow Ticket where
  fromRow = Ticket <$> field
                   <*> field
                   <*> field
                   <*> (Client <$> field)
                   <*> field
                   <*> field
                   <*> field
                   <*> (read <$> field)

formatTargetDate :: Day -> String
formatTargetDate day = formatTime defaultTimeLocale "%x" day
