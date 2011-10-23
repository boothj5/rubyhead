require './lib/card.rb'
require 'test/unit'

class TestCard < Test::Unit::TestCase

    def test_create_sets_rank
        card = Card.new(3, 1)
        assert_equal(3, card.rank)
    end

    def test_create_sets_suit
        card = Card.new(3, 3)
        assert_equal(3, card.suit)
    end

    def test_to_s
        card = Card.new(4, 2)
        result = card.to_s
        assert_equal("FOUR of SPADES", result)
    end

    def test_equal_when_equal_using_first
        card1 = Card.new(4, 3)
        card2 = Card.new(4, 3)
        assert(card1.equals? card2)
    end

    def test_equal_when_equal_using_second
        card1 = Card.new(4, 3)
        card2 = Card.new(4, 3)
        assert(card2.equals? card1)
    end

    def test_not_equal_when_not_using_first
        card1 = Card.new(4, 2)
        card2 = Card.new(3, 1)
        assert(not(card1.equals? card2))
    end

    def test_not_equal_when_not_using_second
        card1 = Card.new(4, 2)
        card2 = Card.new(12, 2)
        assert(not(card2.equals? card1))
    end

    def test_ranks_equal_when_equal_using_first
        card1 = Card.new(6, 2)
        card2 = Card.new(6, 1)
        assert(card1.equals_rank? card2)
    end

    def test_ranks_equal_when_equal_using_second
        card1 = Card.new(6, 2)
        card2 = Card.new(6, 1)
        assert(card2.equals_rank? card1)
    end

    def test_ranks_not_equal_when_not_using_first
        card1 = Card.new(12, 2)
        card2 = Card.new(6, 1)
        assert(not(card1.equals_rank? card2))
    end

    def test_ranks_not_equal_when_not_using_second
        card1 = Card.new(12, 2)
        card2 = Card.new(6, 1)
        assert(not(card2.equals_rank? card1))
    end

    def test_special_card_two
        assert Card.new(2, 3).special_card?
    end

    def test_special_card_seven
        assert Card.new(7, 3).special_card?
    end

    def test_special_card_ten
        assert Card.new(10, 3).special_card?
    end

    def test_special_carda_equal
        card1 = Card.new(2, 4)
        card2 = Card.new(10, 2)
        assert_equal(0, sh_compare(card1, card2))
    end

    def test_first_special_greater
         card1 = Card.new(2, 4)
         card2 = Card.new(4, 2)
         assert_equal(1, sh_compare(card1, card2))
    end

    def test_second_special_less
         card1 = Card.new(8, 4)
         card2 = Card.new(10, 2)
         assert_equal(-1, sh_compare(card1, card2))
    end

    def test_eight_greater_than_four
        card1 = Card.new(8, 4)
        card2 = Card.new(4, 2)
        assert_equal(1, sh_compare(card1, card2))
    end

    def test_jack_less_than_queen
        card1 = Card.new(11, 4)
        card2 = Card.new(12, 2)
        assert_equal(-1, sh_compare(card1, card2))
    end
end
