class Game

    def initialize player_names, num_cards_each
        @cards_each = num_cards_each
        @deck = Deck.new player_names.size, num_cards_each
        @deck.shuffle!
        @players = Array.new
        player_names.each do |name|
            @players.push Player.new name
        end
    end

    def deal!    
        @players.each do |player|
            (1..@cards_each).each do
                player.hand.push @deck.remove_card
                player.face_up.push @deck.remove_card
                player.face_down.push @deck.remove_card
            end
        end
    end

    attr_reader :players
    attr_reader :deck
end
