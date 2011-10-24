require './lib/game.rb'
require 'test/unit'

class TestGame < Test::Unit::TestCase
   
    def setup
        @names = Array.new
        @names.push "James"
        @names.push "David"
        @names.push "Nick"
    end

    def create_game num_cards_each
        @game = Game.new(@names, num_cards_each)
    end

    def test_create_set_correct_num_players
        create_game 4
        assert_equal(3, @game.players.size)
    end

    def test_create_set_correct_deck_size_52
        create_game 4
        assert_equal(52, @game.deck.size)
    end
    
    def test_create_set_correct_deck_size_104
        create_game 20
        assert_equal(208, @game.deck.size)
    end

    def test_create_sets_empty_pile
        create_game 3
        assert @game.pile.empty?
    end
    
    def test_create_sets_blank_last_move
        create_game 3
        assert_equal('', @game.last_move)
    end
    
    def test_deal_deals_correct_amount_to_hands
        create_game 3
        @game.deal!
        assert_equal(3, @game.players[0].hand.size)
        assert_equal(3, @game.players[1].hand.size)
        assert_equal(3, @game.players[2].hand.size)
    end
    
    def test_deal_deals_correct_amount_to_face_ups
        create_game 3
        @game.deal!
        assert_equal(3, @game.players[0].face_up.size)
        assert_equal(3, @game.players[1].face_up.size)
        assert_equal(3, @game.players[2].face_up.size)
    end

    def test_deal_deals_correct_amount_to_face_downs
        create_game 3
        @game.deal!
        assert_equal(3, @game.players[0].face_down.size)
        assert_equal(3, @game.players[1].face_down.size)
        assert_equal(3, @game.players[2].face_down.size)
    end
    
    def test_deal_reduced_deck_size
        create_game 3
        @game.deal!
        assert_equal(25, @game.deck.size)
    end
    
    def test_player_with_lowest_returns_lowest
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(5, 2))
        @game.players[1].hand.push(Card.new(2, 1), Card.new(9, 3))
        @game.players[2].hand.push(Card.new(6, 2), Card.new(4, 4))
        result = @game.player_with_lowest
        
        assert_equal(2, result)
    end

    def test_first_move_lays_cards
        create_game 3
        @game.deal!
        pile_size_before = @game.pile.size
        deck_size_before = @game.deck.size
        @game.first_move!

        assert(pile_size_before < @game.pile.size)
        assert(deck_size_before > @game.deck.size)
    end 

    def test_first_move_lays_both_if_same
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(3, 3), Card.new(3, 1))
        @game.players[1].hand.push(Card.new(4, 2), Card.new(5, 2), Card.new(6, 2))
        @game.players[2].hand.push(Card.new(7, 2), Card.new(8, 2), Card.new(9, 2))

        @game.first_move!

        assert(@game.pile.include? Card.new(3, 3))
        assert(@game.pile.include? Card.new(3, 1))
    end

    def test_play_from_hand_removes_from_hand
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(2, 3), Card.new(2, 1))
        to_lay = Array.new
        to_lay.push Card.new(2, 3)
        to_lay.push Card.new(2, 1)
        @game.play_from_hand! to_lay

        assert (not(@game.players[0].hand.include? Card.new(2, 3)))
        assert (not(@game.players[0].hand.include? Card.new(2, 1)))
    end

    def test_play_from_hand_adds_to_pile
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(2, 3), Card.new(2, 1))
        to_lay = Array.new
        to_lay.push Card.new(2, 3)
        to_lay.push Card.new(2, 1)
        @game.play_from_hand! to_lay

        assert(@game.pile.include? Card.new(2, 3))
        assert(@game.pile.include? Card.new(2, 1))
    end

    def test_play_from_hand_includes_card_in_last_move
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(2, 3), Card.new(2, 1))
        to_lay = Array.new
        to_lay.push Card.new(2, 3)
        to_lay.push Card.new(2, 1)
        @game.play_from_hand! to_lay

        assert(@game.last_move =~ /TWO of CLUBS/i)
        assert(@game.last_move =~ /TWO of HEARTS/i)
    end

    def test_get_current_player_after_deal
        create_game 4
        assert_equal(0, @game.players.index(@game.get_current_player))
    end   

    def test_get_current_player_after_first_move
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(3, 3), Card.new(3, 1))
        @game.players[1].hand.push(Card.new(4, 2), Card.new(5, 2), Card.new(6, 2))
        @game.players[2].hand.push(Card.new(7, 2), Card.new(8, 2), Card.new(9, 2))
        @game.first_move!

        assert_equal(1, @game.players.index(@game.get_current_player))
    end

    def test_move_to_next_player_once
        create_game 3
        @game.move_to_next_player!
        
        assert_equal(1, @game.players.index(@game.get_current_player))
    end

    def test_move_to_next_player_twice
        create_game 3
        @game.move_to_next_player!
        @game.move_to_next_player!
        
        assert_equal(2, @game.players.index(@game.get_current_player))
    end
 
    def test_move_to_next_player_rolls
        create_game 3
        @game.move_to_next_player!
        @game.move_to_next_player!
        @game.move_to_next_player!
        
        assert_equal(0, @game.players.index(@game.get_current_player))
    end

    def test_make_move_removes_from_hand
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(2, 3), Card.new(2, 1))
        to_lay = Array.new
        to_lay.push 1
        to_lay.push 2
        @game.make_move! to_lay

        assert(not(@game.players[0].hand.include? Card.new(2, 3)))
        assert(not(@game.players[0].hand.include? Card.new(2, 1)))
    end

    def test_make_move_adds_to_pile
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(2, 3), Card.new(2, 1))
        to_lay = Array.new
        to_lay.push 1
        to_lay.push 2
        @game.make_move! to_lay

        assert(@game.pile.include? Card.new(2, 3))
        assert(@game.pile.include? Card.new(2, 1))
    end

    def test_make_move_includes_card_in_last_move
        create_game 3
        @game.players[0].hand.push(Card.new(11, 4), Card.new(2, 3), Card.new(2, 1))
        to_lay = Array.new
        to_lay.push 1
        to_lay.push 2
        @game.make_move! to_lay

        assert(@game.last_move =~ /TWO of CLUBS/i)
        assert(@game.last_move =~ /TWO of HEARTS/i)
    end

    def test_continue_game_when_three_players_with_cards
        create_game 3
        @game.players[0].hand.push Card.new(3, 4)
        @game.players[1].face_up.push Card.new(6, 1)
        @game.players[2].face_down.push Card.new(10, 2)

        assert @game.continue?
    end

    def test_continue_game_when_two_players_with_cards
        create_game 3
        @game.players[0].hand.push Card.new(3, 4)
        @game.players[1].face_up.push Card.new(6, 1)

        assert @game.continue?
    end

    def test_not_continue_when_one_player_with_cards
        create_game 3
        @game.players[0].hand.push Card.new(2, 3)
    
        assert(not(@game.continue?))
    end

    def test_current_player_can_move_when_no_cards_on_pile_card_in_hand
        create_game 3
        @game.players[0].hand.push Card.new(3, 4)
    
        assert @game.current_player_can_move?
    end

    def test_current_player_can_move_when_has_two_in_hand
        create_game 3
        @game.players[0].hand.push(Card.new(3, 4), Card.new(2, 3), Card.new(11, 3))
        @game.pile.push Card.new(12, 1)
       
        assert @game.current_player_can_move?
    end 

    def test_current_player_can_move_when_has_seven_in_hand
        create_game 3
        @game.players[0].hand.push(Card.new(3, 4), Card.new(7, 3), Card.new(11, 3))
        @game.pile.push Card.new(12, 1)
       
        assert @game.current_player_can_move?
    end 

    def test_current_player_can_move_when_has_ten_in_hand
        create_game 3
        @game.players[0].hand.push(Card.new(3, 4), Card.new(10, 3), Card.new(11, 3))
        @game.pile.push Card.new(12, 1)
       
        assert @game.current_player_can_move?
    end 

    def test_current_player_can_move_when_same_rank_as_pile_in_hand
        create_game 3
        @game.players[0].hand.push(Card.new(3, 4), Card.new(13, 1), Card.new(6, 4))
        @game.pile.push Card.new(13, 2)

        assert @game.current_player_can_move?
    end
        
    def test_current_player_can_move_when_greater_rank_than_pile_in_hand
        create_game 3
        @game.players[0].hand.push(Card.new(3, 4), Card.new(14, 1), Card.new(6, 4))
        @game.pile.push Card.new(13, 2)

        assert @game.current_player_can_move?
    end

    def test_current_player_can_move_when_no_cards_on_pile_card_in_face_up
        create_game 3
        @game.players[0].face_up.push Card.new(3, 4)
    
        assert @game.current_player_can_move?
    end

    def test_current_player_can_move_when_has_two_in_face_up
        create_game 3
        @game.players[0].face_up.push(Card.new(3, 4), Card.new(2, 3), Card.new(11, 3))
        @game.pile.push Card.new(12, 1)
       
        assert @game.current_player_can_move?
    end 

    def test_current_player_can_move_when_has_seven_in_face_up
        create_game 3
        @game.players[0].face_up.push(Card.new(3, 4), Card.new(7, 3), Card.new(11, 3))
        @game.pile.push Card.new(12, 1)
       
        assert @game.current_player_can_move?
    end 

    def test_current_player_can_move_when_has_ten_in_face_up
        create_game 3
        @game.players[0].face_up.push(Card.new(3, 4), Card.new(10, 3), Card.new(11, 3))
        @game.pile.push Card.new(12, 1)
       
        assert @game.current_player_can_move?
    end 

    def test_current_player_can_move_when_same_rank_as_pile_in_face_up
        create_game 3
        @game.players[0].face_up.push(Card.new(3, 4), Card.new(13, 1), Card.new(6, 4))
        @game.pile.push Card.new(13, 2)

        assert @game.current_player_can_move?
    end
        
    def test_current_player_can_move_when_greater_rank_than_pile_in_face_up
        create_game 3
        @game.players[0].face_up.push(Card.new(3, 4), Card.new(14, 1), Card.new(6, 4))
        @game.pile.push Card.new(13, 2)

        assert @game.current_player_can_move?
    end

    def test_pick_up_adds_pile_to_players_hand
        create_game 3
        @game.pile.push(Card.new(2, 3), Card.new(8, 1), Card.new(5, 2))
        @game.pick_up!
        player = @game.get_current_player
        result = ((player.hand.include? Card.new(2, 3)) and (player.hand.include? Card.new(8, 1)) and
                (player.hand.include? Card.new(5, 2)))

        assert result
    end

    def test_pick_up_remove_from_pile
        create_game 3
        @game.pile.push(Card.new(2, 3), Card.new(8, 1), Card.new(5, 2))
        @game.pick_up!
    
        assert @game.pile.empty?
    end
end
