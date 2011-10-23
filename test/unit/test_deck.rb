require './lib/deck.rb'
require './lib/card.rb'
require 'test/unit'

class TestDeck < Test::Unit::TestCase

    def test_create_one_deck_is_correct_size
        deck = Deck.new(2, 3)
        assert_equal(52, deck.size)
    end

    def test_create_two_decks_correct_size
        deck = Deck.new(2, 10)
        assert_equal(104, deck.size)
    end
    
    def test_create_three_decks_correct_size
        deck = Deck.new(4, 10)
        assert_equal(156, deck.size)
    end
    
    def test_add_card_increments_size
        deck = Deck.new(2, 3)
        deck.add_card Card.new(2, 3)
        assert_equal(53, deck.size)
    end
    
    def test_remove_card_at_index_decrements_size
        deck = Deck.new(2, 3)
        deck.remove_card_at 4
        assert_equal(51, deck.size)
    end
    
    def test_remove_card_decrements_size
        deck = Deck.new(2, 3)
        deck.remove_card
        assert_equal(51, deck.size)
    end
end
