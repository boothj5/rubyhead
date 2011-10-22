require './player.rb'

class Game

    def initialize player_names, num_cards_each
        @cards_each = num_cards_each
        @deck = Deck.new player_names.size, num_cards_each
        @pile = Array.new
        @last_move = ''
        @deck.shuffle!
        @players = Array.new
        player_names.each do |name|
            @players.push Player.new name
        end
        @current_player = 0
    end

    def deal!    
        @players.each do |player|
            (1..@cards_each).each do
                player.hand.push @deck.remove_card
                player.face_up.push @deck.remove_card
                player.face_down.push @deck.remove_card
            end
            player.hand.sort! {|a,b| sh_compare a,b}
        end
    end

    def player_with_lowest
        lowest_player = @players[0]
        @players.each do |test_player|
            if (sh_compare(test_player.lowest_hand_card, lowest_player.lowest_hand_card)<0)
                lowest_player = test_player
            end
        end
        @players.index lowest_player
    end

    def first_move!
        @current_player = player_with_lowest
        to_lay = Array.new
        to_lay.push @players[@current_player].lowest_hand_card

        @players[@current_player].hand.each do |card|
            if ((card.equals_rank? to_lay[0]) and not (card.equals? to_lay[0]))
                to_lay.push card
            end
        end

        play_from_hand! to_lay
    end

    def play_from_hand! to_lay
        to_lay.each do |card|
            @pile.push @players[@current_player].hand.delete card
            @players[@current_player].hand.push @deck.remove_card
        end
        move = "#{@players[@current_player].name} laid the "
        to_lay.each do |card|
            move += "#{card}, "
        end
        @last_move = move
    end

    attr_reader :players
    attr_reader :deck
    attr_reader :pile
    attr_reader :last_move
end
