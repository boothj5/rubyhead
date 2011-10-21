class Player
    def initialize name
        @name = name
        @hand = Array.new
        @face_up = Array.new
        @face_down = Array.new
    end

    attr_reader :name
end

