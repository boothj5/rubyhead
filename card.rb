class Card

    RANKS = { 2 => 'TWO', 3 => 'THREE', 4 => 'FOUR', 5 => 'FIVE', 6 => 'SIX', 
              7 => 'SEVEN', 8 => 'EIGHT', 9 => 'NINE', 10 => 'TEN', 11 => 'JACK', 
              12 => 'QUEEN', 13 => 'KING', 14 => 'ACE' }
    SUITS = { 1 => 'HEARTS', 2 => 'SPADES', 3 => 'CLUBS', 4 => 'DIAMONDS' }

    def initialize rank, suit
        @rank = rank
        @suit = suit
    end

    def to_s
        "#{RANKS[@rank]} of #{SUITS[@suit]}"
    end

    attr_reader :rank
    attr_reader :suit
end
