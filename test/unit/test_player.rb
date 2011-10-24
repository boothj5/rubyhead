require './lib/player.rb'
require 'test/unit'

class TestPlayer < Test::Unit::TestCase

    def test_create_sets_name
        player = Player.new "James"
        assert_equal(player.name, "James")
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
        two_clubs = Card.new(2, 3)
        seven_spades = Card.new(7, 2)
        five_hearts = Card.new(5, 1)
        jack_hearts = Card.new(11, 1)
        ten_hearts = Card.new(10, 1)
        four_diamonds = Card.new(4, 4)
        
        player = Player.new "James"
        player.hand.push two_clubs
        player.hand.push seven_spades
        player.hand.push five_hearts
        player.face_up.push jack_hearts
        player.face_up.push ten_hearts
        player.face_up.push four_diamonds

        player.swap!(0, 2)

        assert((player.hand.include? four_diamonds), "Hand doesnt include new card")
        assert((not(player.hand.include? two_clubs)), "Hand still includes card")
        assert((player.face_up.include? two_clubs), "Face up doesnt include card")
        assert((not(player.face_up.include? four_diamonds)), "Face up still includes card")
    end

    def test_lowest_hand_card
        two_clubs = Card.new(2, 3)
        seven_spades = Card.new(7, 2)
        five_hearts = Card.new(5, 1)
        jack_hearts = Card.new(11, 1)
        ten_hearts = Card.new(10, 1)
        four_diamonds = Card.new(4, 4)
        
        player = Player.new "James"
        player.hand.push two_clubs
        player.hand.push seven_spades
        player.hand.push five_hearts
        player.hand.push ten_hearts
        player.hand.push four_diamonds
        
        assert_equal(four_diamonds, player.lowest_hand_card)
    end

    def test_player_has_cards_when_hand_has
        player = Player.new "James"
        player.hand.push Card.new(2, 3)
    
        assert player.has_cards?
    end

    def test_player_has_cards_when_face_up_does
        player = Player.new "James"
        player.face_up.push Card.new(5, 1)

        assert player.has_cards?
    end

    def test_player_has_cards_when_face_down_does
        player = Player.new "James"
        player.face_down.push Card.new(10, 4)

        assert player.has_cards?
    end

    def test_player_doesnt_have_cards
        player = Player.new "James"
        
        assert (not player.has_cards?)
    end

    def test_has_special_card_in_hand_when_two
        player = Player.new "James"
        player.hand.push Card.new(5, 3)
        player.hand.push Card.new(2, 1)
        player.hand.push Card.new(6, 4)

        assert player.has_special_card_in_hand?
    end

    def test_has_special_card_in_hand_when_seven
        player = Player.new "James"
        player.hand.push Card.new(5, 3)
        player.hand.push Card.new(7, 1)
        player.hand.push Card.new(6, 4)

        assert player.has_special_card_in_hand?
    end

    def test_has_special_card_in_hand_when_ten
        player = Player.new "James"
        player.hand.push Card.new(5, 3)
        player.hand.push Card.new(10, 1)
        player.hand.push Card.new(6, 4)

        assert player.has_special_card_in_hand?
    end

    def test_not_has_special_card_when_no_cards
        player = Player.new "James"

        assert(not(player.has_special_card_in_hand?))
    end

    def test_not_has_special_card_when_no_special
        player = Player.new "James"
        player.hand.push Card.new(3,4)
        player.hand.push Card.new(9,1)
        player.hand.push Card.new(14,4)

        assert(not(player.has_special_card_in_hand?))
    end

    def test_has_cards_in_hand
        player = Player.new "James"
        player.hand.push Card.new(2, 3)

        assert player.has_cards_in_hand?
    end

    def test_not_has_cards_in_hand
        player = Player.new "James"
        
        assert (not(player.has_cards_in_hand?))
    end

    def test_has_cards_in_face_up
        player = Player.new "James"
        player.face_up.push Card.new(6, 1)

        assert player.has_cards_in_face_up?
    end

    def test_not_has_cards_in_face_up
        player = Player.new "James"
        
        assert (not(player.has_cards_in_face_up?))
    end
    
    def test_has_special_card_in_face_up_when_two
        player = Player.new "James"
        player.face_up.push Card.new(5, 3)
        player.face_up.push Card.new(2, 1)
        player.face_up.push Card.new(6, 4)

        assert player.has_special_card_in_face_up?
    end

    def test_has_special_card_in_face_up_when_seven
        player = Player.new "James"
        player.face_up.push Card.new(5, 3)
        player.face_up.push Card.new(7, 1)
        player.face_up.push Card.new(6, 4)

        assert player.has_special_card_in_face_up?
    end

    def test_has_special_card_in_face_up_when_ten
        player = Player.new "James"
        player.face_up.push Card.new(5, 3)
        player.face_up.push Card.new(10, 1)
        player.face_up.push Card.new(6, 4)

        assert player.has_special_card_in_face_up?
    end

    def test_not_has_special_card_face_up_when_no_cards
        player = Player.new "James"

        assert(not(player.has_special_card_in_face_up?))
    end

    def test_not_has_special_card_face_up_when_no_special
        player = Player.new "James"
        player.face_up.push Card.new(3,4)
        player.face_up.push Card.new(9,1)
        player.face_up.push Card.new(14,4)

        assert(not(player.has_special_card_in_face_up?))
    end

    def test_add_to_hand_adds_cards
        player = Player.new "James"
        player.hand.push(Card.new(2, 4), Card.new(9, 1))
        player.add_to_hand!( [ Card.new(10, 4), Card.new(8, 3) ] )

        assert ((player.hand.include? Card.new(10, 4)) and (player.hand.include? Card.new(8, 3)))
    end
end

    
