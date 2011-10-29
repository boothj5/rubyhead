require './lib/player.rb'
require './lib/deck.rb'

class Game

    attr_reader :players
    attr_reader :deck
    attr_reader :pile
    attr_reader :burnt
    attr_reader :last_move

    def initialize(player_names, num_cards_each)
        @cards_each = num_cards_each
        @deck = Deck.new(player_names.size, num_cards_each)
        @pile = Array.new
        @burnt = Array.new
        @last_move = ''
        @deck.shuffle!
        @players = Array.new
        player_names.each do |name|
            @players.push Player.new(name)
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
            player.hand.sort! {|a,b| Card.sh_compare(a,b)}
        end
    end

    def first_move!
        @current_player = player_with_lowest
        player = get_current_player
        to_lay = Array.new
        to_lay.push player.lowest_hand_card

        player.hand.each do |card|
            if ((card.equals_rank? to_lay[0]) and not (card == to_lay[0]))
                to_lay.push card
            end
        end

        play_from_hand! to_lay
        move_to_next_player!
    end

    def move_to_next_player!
        @current_player+=1
        if @current_player >= @players.size
            @current_player = 0
        end
    end

    def make_move! to_lay
        player = get_current_player
        cards_to_lay = to_lay.map { |i| player.hand[i] }
        if player.has_cards_in_hand?
            cards_to_lay = to_lay.map { |i| player.hand[i] }
            play_from_hand! cards_to_lay
        else
            cards_to_lay = to_lay.map { |i| player.face_up[i] }
            play_from_face_up! cards_to_lay
        end
        if burn_pile?
            burn!
        elsif miss_a_go?
            @last_move = "#{player.name} layed miss a go card."
        else
            move_to_next_player!
        end
    end

    def get_current_player
        @players[@current_player]
    end

    def continue?
        players_with_cards = 0
        @players.each do |player|
            if player.has_cards?
                players_with_cards += 1
            end
        end
        return players_with_cards > 1
    end

    def current_player_can_move?
        player = get_current_player
        return true if @pile.empty?
        
        if player.has_cards_in_hand?
            return true if (can_move_with? player.hand)
        elsif player.has_cards_in_face_up?
            return true if (can_move_with? player.face_up)
        end

        return false
    end


    def pick_up!
        player = get_current_player
        player.add_to_hand! @pile
        player.hand.sort! {|a,b| Card.sh_compare(a,b)}
        @pile.clear
        @last_move = "#{player.name} picked up"
    end

    def valid_move? to_lay
        player = get_current_player
        cards_to_lay = Array.new
        if player.has_cards_in_hand?
            cards_to_lay = to_lay.map { |i| player.hand[i] }
        else
            cards_to_lay = to_lay.map { |i| player.face_up[i] }
        end 
        return Game.valid_move_on_pile?(cards_to_lay, @pile)
    end

    private
    def can_move_with? cards
        cards.each_index do |i|
            return true if (valid_move? Array.new([i]))
        end
        return false
    end

    def burn!
        player = get_current_player
        @burnt += @pile
        @pile.clear
        @last_move = "#{player.name} burnt the deck"
    end

    def player_with_lowest
        lowest_player = @players[0]
        @players.each do |test_player|
            if (Card.sh_compare(test_player.lowest_hand_card, lowest_player.lowest_hand_card)<0)
                lowest_player = test_player
            end
        end
        @players.index lowest_player
    end

    def play_from_hand! to_lay
        player = get_current_player
        to_lay.each do |card|
            @pile.push(player.hand.delete card)
            player.hand.push @deck.remove_card if (not(@deck.empty?) and (player.hand.size < @cards_each))
        end
        player.hand.sort! {|a,b| Card.sh_compare(a,b)}
        move = "#{player.name} laid the "
        to_lay.each do |card|
            move += "#{card}, "
        end
        @last_move = move
    end

    def play_from_face_up! to_lay
        player = get_current_player
        to_lay.each do |card|
            @pile.push(player.face_up.delete card)
            player.face_up.push @deck.remove_card if (not(@deck.empty?))
        end
        move = "#{player.name} laid the "
        to_lay.each do |card|
            move += "#{card}, "
        end
        @last_move = move
    end

    def burn_pile?
        return true if (@pile.last.rank == 10)
        if @pile.size > 3
            return true if (Card.all_ranks_equal? @pile.last(4))
        end    
        return false
    end

    def miss_a_go?
        return (@pile.last.rank == 8)
    end

    def Game.valid_move_on_pile?(cards_to_lay, pile)
        return false unless Card.all_ranks_equal? cards_to_lay
        return true if pile.empty?
        return true if cards_to_lay[0].special_card?
        return (valid_move_on_pile?(cards_to_lay, pile.first(pile.size - 1))) if (pile.last.rank == 7)
        return false if (cards_to_lay[0].rank < pile.last.rank)
        return true
    end
end
