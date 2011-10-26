require './lib/card.rb'

class Player

    attr_reader :name
    attr_reader :hand
    attr_reader :face_up
    attr_reader :face_down

    def initialize name
        @name = name
        @hand = Array.new
        @face_up = Array.new
        @face_down = Array.new
    end

    def swap!(hand_card, face_up_card)
        temp = @hand[hand_card]
        @hand[hand_card] = @face_up[face_up_card]
        @face_up[face_up_card] = temp
        @hand.sort! {|a,b| Card.sh_compare(a, b)}
    end
        
    def lowest_hand_card
        lowest_card = @hand[0]
        @hand.each do |card|
            if (Card.sh_compare(card, lowest_card) < 0)
                lowest_card = card
            end
        end
        lowest_card
    end

    def has_cards?
        return true unless ((@hand.empty?) and (@face_up.empty?) and (@face_down.empty?))
    end

    def has_special_card_in_hand?
        @hand.each do |card|
            return true if card.special_card?
        end
        return false
    end

    def has_special_card_in_face_up?
        @face_up.each do |card|
            return true if card.special_card?
        end
        return false
    end

    def has_cards_in_hand?
        return true unless @hand.empty?
    end

    def has_cards_in_face_up?
        return true unless @face_up.empty?
    end

    def add_to_hand! cards
        @hand += cards
    end
    
end

