#!/usr/bin/env bash
# exit on error
set -o errexit
bundle lock --update
bundle install
rails db:create
rails db:migrate
rails db:seed
