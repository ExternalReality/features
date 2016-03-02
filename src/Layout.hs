{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Layout
  ( baseLayout
  , renderWithLayout
  , renderWithBaseLayout
  ) where

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

renderWithLayout :: Html -> Handler App (AuthManager App) ()
renderWithLayout content = do
  user <- currentUser
  case user of
    Nothing -> redirect "/login"
    Just u  -> do
      let l = userLogin u
      blaze . (appLayout l) $ content

renderWithBaseLayout :: Html -> Handler App (AuthManager App) ()
renderWithBaseLayout content = blaze . baseLayout $ content

appLayout :: Text -> Html -> Html
appLayout _ content = baseLayout $ [shamlet|
<div class="container" style="max-width: none">
  #{content}
|]

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
    <script src="/static/prototype.js">
    <script src="/static/form-to-obj.min.js">
    <script> #{ticketFormJS}
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/skeleton/2.0.4/skeleton.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/static/prototype.css">
    <link rel="stylesheet" href="http://parsleyjs.org/src/parsley.css">
  <body>
    #{content}
|]
