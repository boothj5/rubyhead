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


game.players.each do |player|
    clearscreen
    show_player player, false
    newline
    print "#{player.name}, would you like to swap cards?"
    swap = gets.chomp
end 

clearscreen
show_game game
