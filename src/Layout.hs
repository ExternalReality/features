{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Layout
  ( baseLayout
--  , renderWithLayout
  , renderWithBaseLayout
  ) where

import           Data.Monoid                                 ((<>))
import           Data.Text
import           Snap
import           Snap.Blaze                                  (blaze)
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.PostgresqlSimple ()

import           Text.Blaze.Html                             (Html,
                                                              preEscapedText)
import           Text.Hamlet                                 (shamlet)

import           Application
--import           User.Query                                  (userDBView)

-- renderWithLayout :: Html -> Handler App (AuthManager App) ()
-- renderWithLayout content = do
--   user <- currentUser
--   case user of
--     Nothing -> redirect "/login"
--     Just u  -> do
--       let (Just (UserId id_)) = userId u
--       [x] <- query userDBView (Only id_)
--       blaze . (appLayout x) $ content

renderWithBaseLayout :: Html -> Handler App (AuthManager App) ()
renderWithBaseLayout content = blaze . baseLayout $ content

appLayout :: (Text, Text, Role) -> Html -> Html
appLayout (fname, lname, role) content = baseLayout $ [shamlet|
<div class="container" style="max-width: none">
  <div class="row">
    #{content}
|]
  where
   fullname = fname <> " " <> lname

ticketFormJS :: Html
ticketFormJS = preEscapedText "$(document).ready(function() {$('#due-date').datepicker({showOn: 'button', buttonText: '&#xf073;'});})"

baseLayout :: Html -> Html
baseLayout content = [shamlet|
<!doctype HTML>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Features</title>
    <meta name="description" content="Content Queue Application">
    <script src="https://code.jquery.com/jquery-2.2.0.min.js">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/parsley.js/2.2.0/parsley.min.js">
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js">
    <script src="/static/skeleton-tabs.js">
    <script> #{ticketFormJS}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/skeleton/2.0.4/skeleton.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/static/prototype.css">
    <link rel="stylesheet" href="http://parsleyjs.org/src/parsley.css">
    <link rel="stylesheet" href="/static/skeleton-tabs.css">
  <body>
    #{content}
|]
