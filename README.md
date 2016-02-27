# features

[![Stories in In Progress](https://badge.waffle.io/ExternalReality/features.png?label=in progress&title=In Progress)](http://waffle.io/ExternalReality/features) [![Stories in Done](https://badge.waffle.io/ExternalReality/features.png?label=done&title=Done)](http://waffle.io/ExternalReality/features) [![Circle CI](https://circleci.com/gh/ExternalReality/features.svg?style=shield)](https://circleci.com/gh/ExternalReality/features)

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
- setup Haskell environment `stack setup`
- install project dependencies `stack install`
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
- Use the docker image of the development environment that I am going to provide.
