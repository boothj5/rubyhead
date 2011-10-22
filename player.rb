require './card.rb'

class Player
    def initialize name
        @name = name
        @hand = Array.new
        @face_up = Array.new
        @face_down = Array.new
    end

    def swap hand_card, face_up_card
        temp = @hand[hand_card]
        @hand[hand_card] = @face_up[face_up_card]
        @face_up[face_up_card] = temp
        @hand.sort! {|a,b| sh_compare a, b}
    end
        

    attr_reader :name
    attr_reader :hand
    attr_reader :face_up
    attr_reader :face_down
end

