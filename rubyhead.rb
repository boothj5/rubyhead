require './console.rb'
require './deck.rb'
require './game.rb'
require './player.rb'

clearscreen
show_welcome_msg
nplayers = request_num_players
ncards = request_num_cards
player_names = request_player_names nplayers
game = Game.new player_names, ncards
game.deal!

clearscreen
show_game game

