class Player
    def initialize name
        @name = name
        @hand = Array.new
        @face_up = Array.new
        @face_down = Array.new
    end

    attr_reader :name
    attr_reader :hand
    attr_reader :face_up
    attr_reader :face_down
end

