 {-# LANGUAGE OverloadedStrings #-}
 {-# LANGUAGE QuasiQuotes       #-}

module Ticket.Types ( Ticket(..)
                    , ProductArea(..)
                    , Client(..)
                    , formatTargetDate
                    ) where

import Data.Text (Text, unpack)
import Data.Time.Calendar (Day)
import Data.Time.Format
import Database.PostgreSQL.Simple.FromRow
import Data.Aeson

data Client = Client {clientName :: Text}
  deriving (Eq, Show)

instance FromRow Client where
  fromRow = Client <$> field

instance FromJSON Client where
  parseJSON (String s) =  return $ Client s

data ProductArea = Policies | Billing | Claims | Reports
  deriving (Show, Eq, Read)

instance FromRow ProductArea where
  fromRow = read <$> field

instance FromJSON ProductArea where
   parseJSON (String s) = return $ read (unpack s)

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

instance FromJSON Ticket where
  parseJSON v@(Object o) = Ticket <$>
                         o .:? "ticketId" <*>
                         o .: "title" <*>
                         o .: "description" <*>
                         o .: "client" <*>
                         o .:? "clientPriority" .!= 0 <*>
                         o .: "targetDate" <*>
                         o .:? "url" <*>
                         o .: "productArea"

instance FromJSON Day where
  parseJSON = withText "Day" $ \t ->
    case parseTime defaultTimeLocale "%x" (unpack t) of
      Just d -> pure d
      _      -> fail "could not parse date"

formatTargetDate :: Day -> String
formatTargetDate day = formatTime defaultTimeLocale "%x" day
