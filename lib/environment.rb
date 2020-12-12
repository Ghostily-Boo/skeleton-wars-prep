require "dotenv/load"
require 'json'
require 'pry'
require 'open-uri'
require 'tty-prompt'
require 'catpix'

require "colorize" #to be used later by cli.rb

require_relative "./skeletons/api"
require_relative "./skeletons/cli"
require_relative "./skeletons/full_skel"
require_relative "./skeletons/version"