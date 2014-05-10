require 'appscript'
require 'pry'

require_relative 'player'
require_relative 'track'
require_relative 'searcher'
require_relative 'switcher'

# netsky/rusko - everyday
Music::Player.play('0D64E70AB638D696')



binding.pry
puts Music::Track.new.summary
puts Music::Player.state
puts Music::Player.position
sleep 2
# # print out current state
# puts Music::Track.new.summary
# puts Music::Player.state
# puts Music::Player.position
# sleep 2

# # skip to the drop, yo
# Music::Player.position = 45
# puts Music::Track.new.summary
# puts Music::Player.state
# puts Music::Player.position
# sleep 2

# # restart
# Music::Player.position = 0
# puts Music::Track.new.summary
# puts Music::Player.state
# puts Music::Player.position
# sleep 2


Music::Switcher.switch('5BBFD86C712F8127', 5)

# # rick ross - push it
# Music::Player.play('5BBFD86C712F8127')
# puts Music::Track.new.summary
# puts Music::Player.state
# puts Music::Player.position
