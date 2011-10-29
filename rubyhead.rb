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
    if game.playing_from_face_down?
        chosen_card = request_face_down_card game.get_current_player.name
        if(game.valid_move_from_face_down? chosen_card)
            show_face_down_win game.get_current_player.face_down[chosen_card]
            game.make_face_down_move! chosen_card
        else
            show_face_down_fail game.get_current_player.face_down[chosen_card]
            game.pickup_pile_and_face_down! chosen_card
            game.move_to_next_player!
        end
    elsif game.current_player_can_move?
        chosen_cards = request_move game.get_current_player
        if(game.valid_move? chosen_cards)
            game.make_move! chosen_cards
        else
            show_bad_move
        end
    else
        show_pickup_msg game.get_current_player.name
        game.pick_up!
        game.move_to_next_player!
    end
end

show_rubyhead game.get_rubyhead
