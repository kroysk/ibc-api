#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
# rails db:create RAILS_ENV=production
rails db:migrate RAILS_ENV=production
rails db:seed  RAILS_ENV=production
