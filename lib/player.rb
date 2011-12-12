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
        return (has_cards_in_hand? or has_cards_in_face_up? or has_cards_in_face_down?)
    end

    def has_special_card_in_hand?
        @hand.each do |card|
            if card.special_card?
                return true
            end
        end
        return false
    end

    def has_special_card_in_face_up?
        @face_up.each do |card|
            if card.special_card?
                return true
            end
        end
        return false
    end

    def has_cards_in_hand?
        return (not @hand.empty?)
    end

    def has_cards_in_face_up?
        return (not @face_up.empty?)
    end

    def has_cards_in_face_down?
        return (not @face_down.empty?)
    end

    def add_to_hand! cards
        @hand += cards
    end
    
end

