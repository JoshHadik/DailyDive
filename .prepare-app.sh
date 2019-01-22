#!/bin/bash

echo Creating the database
bundle exec rails db:create

echo Migrating the database
bundle exec rails db:migrate

echo Precompiling Assets
bundle exec rails assets:precompile
