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

    def <=> other
        return nil unless other.instance_of? Card
        return self.rank <=> other.rank
    end

    attr_reader :rank
    attr_reader :suit
end

def sh_compare card1, card2
    return false unless (card1.instance_of? Card and card2.instance_of? Card)
    if (special_card card1 and special_card card2)
        return 0
    elsif (special_card card1 and not special_card card2)
        return 1
    elsif (special_card card2)
        return -1
    else
        card1 <=> card2
    end
end

def special_card card
    return (card.rank == 2 or card.rank == 7 or card.rank == 10)
end
