require 'json'
require 'yaml'
require 'bundler/setup'
Bundler.require
require "./lib/app"

run Sinatra::Application
