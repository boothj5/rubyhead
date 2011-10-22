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
    swap = (gets.chomp.downcase == "y") ? true : false

    while swap
        print "Choose a hand card (1-#{ncards}): "
        hand_card = gets.chomp.to_i - 1
        print "Choose a face up card (1-#{ncards}): "
        face_up_card = gets.chomp.to_i - 1
        player.swap hand_card, face_up_card
        clearscreen
        show_player player, false
        newline
        print 'Would you like to swap more cards? '
        swap = (gets.chomp.downcase == "y") ? true : false
    end
end 

clearscreen
show_game game
