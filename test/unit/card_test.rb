require './card.rb'
require 'test/unit'

class TestCard < Test::Unit::TestCase

    def test_create_sets_rank
        card = Card.new 3, 1
        assert_equal 3, card.rank
    end

    def test_create_sets_suit
        card = Card.new 3, 3
        assert_equal 3, card.suit
    end

    def test_to_s
        card = Card.new 4, 2
        result = card.to_s
        assert_equal "FOUR of SPADES", result
    end
end
