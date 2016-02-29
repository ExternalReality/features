# features

[![Stories in Ready](https://badge.waffle.io/ExternalReality/features.png?label=ready&title=Ready)](http://waffle.io/ExternalReality/features) [![Stories in In Progress](https://badge.waffle.io/ExternalReality/features.png?label=in progress&title=In Progress)](http://waffle.io/ExternalReality/features) [![CircleCI](https://circleci.com/gh/ExternalReality/features.svg?style=shield)](https://circleci.com/gh/ExternalReality/features)

## A simple application that manages feature requests

### Setup development environment

#### Install the system development dependencies

- install the [Haskell tool stack](http://docs.haskellstack.org/en/stable/install_and_upgrade/#mac-os-x)
- install [postgreSQL](http://www.postgresql.org/download/macosx/)
- install the [migration tool flyway](http://flywaydb.org/blog/homebrew.html#1802)

#### Clone the repository
- clone this repository


#### Setup the database
- You have postgreSQL intalled now `createdb features`
- The application is not configured with a database password so, in order to give the
  application and flyway access, you must:
  - go to your postgreSQL configuration `pg_hba.conf` and set IPv4/6 local connections to `trust` rather than `md5`
    - this is ok for most development environments but not safe for production.
  - alternatively, you may use a password and set the password in `snaplets/postgresql-simple/devel.cfg` and in `flyway.conf`
- run `flyway migrate` from the project root to migrate the database

#### Setup the development environment
- run `cd path/to/repo` to change directories to the project root 
- setup Haskell environment `stack setup`
- install project dependencies `stack install --only-dependencies`
- build the project in development mode so that the application updates without rebuild `stack build --flag features:development`
- run the application with `stack exec features`

#### Test Setup & Running Tests
- for acceptance testing we use Ruby's excellent [Capybara](https://jnicklas.github.io/capybara/)
- install a modern Ruby using [rvm](https://rvm.io/)
- run `gem install bundler`
- run `bundle install` or just `bundle` and keep an eye out for any missing system dependencies (e.g webkit)
- to run the acceptance tests use `rspec`

- To run the Haskell unit tests (TBA)

#### Alternative Setup
- Use the docker image of the development environment that I am going to provide (TBA)


#### Spacemacs

The following Spacemacs layers make it easy to work on this project:
  - emacs-lisp
  - git
  - markdown
  - haskell
  - latex
  - yaml
  - auto-completion
  - spell-checking

Also you can set these as directory level settings so your stack ghci repl rebuilds in dev mode:
 '(haskell-compile-cabal-build-alt-command "cd %s && stack build --flag features:development")
 '(haskell-compile-cabal-build-command "cd %s && stack build --flag features:development")
 
 #### Other things
 - Listen to the Tao Te Ching audio book while coding and configuring servers and stuff.
 - Use the 'deeper blue' Emacs24 theme because IMHO it calms the soul.
 
