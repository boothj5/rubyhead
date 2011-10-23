require './player.rb'
require 'test/unit'

class TestCard < Test::Unit::TestCase

    def test_create_sets_name
        player = Player.new "James"
        assert_equal player.name, "James"
    end

    def test_create_set_empty_hand
        player = Player.new "James"
        assert player.hand.empty?
    end

    def test_create_set_empty_face_up
        player = Player.new "James"
        assert player.face_up.empty?
    end

    def test_create_set_empty_face_down
        player = Player.new "James"
        assert player.face_down.empty?
    end

    def test_swap_cards
        two_clubs = Card.new 2, 3
        seven_spades = Card.new 7, 2
        five_hearts = Card.new 5, 1
        jack_hearts = Card.new 11, 1
        ten_hearts = Card.new 10, 1
        four_diamonds = Card.new 4, 4
        
        player = Player.new "James"
        player.hand.push two_clubs
        player.hand.push seven_spades
        player.hand.push five_hearts
        player.face_up.push jack_hearts
        player.face_up.push ten_hearts
        player.face_up.push four_diamonds

        player.swap! 0, 2

        assert (player.hand.include? four_diamonds), "Hand doesnt include new card"
        assert (not(player.hand.include? two_clubs)), "Hand still includes card"
        assert (player.face_up.include? two_clubs), "Face up doesnt include card"
        assert (not(player.face_up.include? four_diamonds)), "Face up still includes card"
    end

    def test_lowest_hand_card
        two_clubs = Card.new 2, 3
        seven_spades = Card.new 7, 2
        five_hearts = Card.new 5, 1
        jack_hearts = Card.new 11, 1
        ten_hearts = Card.new 10, 1
        four_diamonds = Card.new 4, 4
        
        player = Player.new "James"
        player.hand.push two_clubs
        player.hand.push seven_spades
        player.hand.push five_hearts
        player.hand.push ten_hearts
        player.hand.push four_diamonds
        
        assert_equal player.lowest_hand_card, four_diamonds
    end
end

    
