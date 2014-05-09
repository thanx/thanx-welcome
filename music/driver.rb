require 'appscript'
require 'pry'

require_relative 'player'
require_relative 'track'

puts Music::Track.new.summary
Music::Player.play

sleep 2

Music::Player.pause


