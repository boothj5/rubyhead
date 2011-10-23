require './lib/card.rb'

class Player
    def initialize name
        @name = name
        @hand = Array.new
        @face_up = Array.new
        @face_down = Array.new
    end

    def swap! hand_card, face_up_card
        temp = @hand[hand_card]
        @hand[hand_card] = @face_up[face_up_card]
        @face_up[face_up_card] = temp
        @hand.sort! {|a,b| sh_compare a, b}
    end
        
    def lowest_hand_card
        lowest_card = @hand[0]
        @hand.each do |card|
            if (sh_compare(card, lowest_card) < 0)
                lowest_card = card
            end
        end
        lowest_card
    end

    def has_cards?
        return true unless ((@hand.empty?) and (@face_up.empty?) and (@face_down.empty?))
    end
    
    attr_reader :name
    attr_reader :hand
    attr_reader :face_up
    attr_reader :face_down
end

