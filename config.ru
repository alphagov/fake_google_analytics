require 'json'
require 'yaml'
require 'bundler/setup'
Bundler.require
Datainsight::Logging.configure
require "./lib/app"

run Sinatra::Application
