require './lib/console.rb'
require './lib/deck.rb'
require './lib/game.rb'
require './lib/player.rb'

clearscreen
show_welcome_msg
nplayers = request_num_players
ncards = request_num_cards
player_names = request_player_names nplayers
game = Game.new(player_names, ncards)
game.deal!

game.players.each do |player|
    clearscreen
    show_player(player, false)
    newline
    swap = request_swap player.name

    while swap
        hand_card = request_hand_swap ncards
        face_up_card = request_face_up_swap ncards
        player.swap!(hand_card, face_up_card)
        clearscreen
        show_player(player, false)
        newline
        swap = request_swap_more
    end
end 

game.first_move!

while game.continue? do
    clearscreen
    show_game game
    if game.current_player_can_move?
        chosen_cards = request_move game.get_current_player
        if(game.valid_move? chosen_cards)
            game.make_move! chosen_cards
        else
            show_bad_move game.get_current_player.name
        end
    else
        show_pickup_msg game.get_current_player.name
        game.pick_up!
        game.move_to_next_player!
    end
end
