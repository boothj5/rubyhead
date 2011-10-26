require './lib/card.rb'

class Deck

    def initialize(num_players, num_cards_each)
        @deck = Array.new
        num_decks = Deck.calc_num_decks(num_players, num_cards_each)

        (1..num_decks).each do 
            (2..Card::RANKS.size+1).each do |rank|
                (1..Card::SUITS.size).each do |suit|
                    add_card Card.new(rank, suit)
                end
            end
        end
    end

    def each &blk
        @deck.each &blk
    end

    def size
        @deck.size
    end

    def add_card card
        @deck.push card
    end

    def remove_card_at index
        @deck.delete_at index
    end

    def remove_card
        @deck.pop
    end

    def shuffle!
        size.downto(1) { |n| add_card remove_card_at(rand(n)) }
    end

    private
    def Deck.calc_num_decks(num_players, num_cards_each)
        total_cards = (num_cards_each * 3) * num_players
        div = total_cards / 52
        add = ((total_cards % 52) > 0) ? 1 : 0
        return div + add
    end
end
        
