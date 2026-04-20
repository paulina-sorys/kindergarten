# Way of work

1. Write test
2. Run test and tel it fail
3. Write silly implementation just to make it green
4. Upgrade implementation
5. Run test very often

# What is where

## ruby version

see file .ruby-version

## lint

run rubocop -a

To run controller tests

```rails test test/controllers/<controller_test_name.rb>```

To run only one test case temporarly import dependency

```require "minitest/focus"```

and type ```focus``` above test case you want tot run.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
