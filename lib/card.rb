class Card

    RANKS = { 2 => 'TWO', 3 => 'THREE', 4 => 'FOUR', 5 => 'FIVE', 6 => 'SIX', 
              7 => 'SEVEN', 8 => 'EIGHT', 9 => 'NINE', 10 => 'TEN', 11 => 'JACK', 
              12 => 'QUEEN', 13 => 'KING', 14 => 'ACE' }
    SUITS = { 1 => 'HEARTS', 2 => 'SPADES', 3 => 'CLUBS', 4 => 'DIAMONDS' }

    def initialize(rank, suit)
        @rank = rank
        @suit = suit
    end

    def to_s
        return "#{RANKS[@rank]} of #{SUITS[@suit]}"
    end

    def equals? other
        return nil unless other.instance_of? Card
        return (self.rank == other.rank and self.suit == other.suit)
    end

    def equals_rank? other
        return nil unless other.instance_of? Card
        return self.rank == other.rank
    end

    def special_card?
        return (@rank == 2 or @rank == 7 or @rank == 10)
    end
    
    attr_reader :rank
    attr_reader :suit
end

def sh_compare(card1, card2)
    return false unless (card1.instance_of? Card and card2.instance_of? Card)
    if (card1.special_card? and card2.special_card?)
        return 0
    elsif (card1.special_card? and not card2.special_card?)
        return 1
    elsif (card2.special_card?)
        return -1
    else
        card1.rank <=> card2.rank
    end
end


