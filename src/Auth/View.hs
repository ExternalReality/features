{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Auth.View (loginForm) where

import           Data.Text       (Text)
import           Text.Blaze.Html (Html)
import           Text.Hamlet     (shamlet)

loginForm :: Maybe Text -> Html
loginForm maybeAuthError = [shamlet|

<div class="container" style="margin-top: 10%">
  <div class="row">
      <div class="two columns offset-by-three" style="margin-bottom: 2em">
        <img id="auth-logo" src="static/BriteCoreLogo.png">
        <span id="application-name">Features</span>

  <form class="form loginForm" method="post" action="/">
    <div class="row">
      <label for="name" class="two columns offset-by-three">Login
      <input type="text" name="login" size="20" class="four columns" data-parsley-type="email" required="">

    <div class="row">
      <label for="password" class="two columns offset-by-three">Password
      <input type="password" name="password" size="20" class="four columns" required="">

    <div class="row">
      <input type="submit" id="login_button" value="Sign in" class="four columns offset-by-five">

    <div class="row">
     <div class="errors three columns offset-by-five">
       $maybe authError <- maybeAuthError
         #{authError}

|]
