class Card

    attr_reader :rank
    attr_reader :suit
   
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

    def == other
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

    def Card.sh_compare(card1, card2)
        return nil unless (card1.instance_of? Card and card2.instance_of? Card)
        return 0 if (card1.special_card? and card2.special_card?)
        return 1 if (card1.special_card? and not card2.special_card?)
        return -1 if (card2.special_card?)
        return card1.rank <=> card2.rank
    end

    def Card.all_ranks_equal? cards
        return false if cards.empty?
        cards.each do |card|
            return false unless (card.equals_rank? cards[0])
        end
        return true
    end

end
