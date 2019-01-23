#!/bin/bash

echo Migrating the database
bundle exec rails db:migrate

echo Precompiling Assets
bundle exec rails assets:precompile
