require './lib/game.rb'
require 'test/unit'

class TestGame < Test::Unit::TestCase
   
    def create_player_names
        names = Array.new
        names.push "James"
        names.push "David"
        names.push "Nick"
        return names
    end
    
    def test_create_set_correct_num_players
        names = create_player_names
        game = Game.new names, 4
        assert_equal 3, game.players.size
    end

    def test_create_set_correct_deck_size_52
        names = create_player_names
        game = Game.new names, 4
        assert_equal 52, game.deck.size
    end
    
    def test_create_set_correct_deck_size_104
        names = create_player_names
        game = Game.new names, 20
        assert_equal 208, game.deck.size
    end

    def test_create_sets_empty_pile
        names = create_player_names
        game = Game.new names, 3
        assert game.pile.empty?
    end
    
    def test_create_sets_blank_last_move
        names = create_player_names
        game = Game.new names, 3
        assert_equal '', game.last_move
    end
    
    def test_deal_deals_correct_amount_to_hands
        names = create_player_names
        game = Game.new names, 3
        game.deal!
        assert_equal 3, game.players[0].hand.size
        assert_equal 3, game.players[1].hand.size
        assert_equal 3, game.players[2].hand.size
    end
    
    def test_deal_deals_correct_amount_to_face_ups
        names = create_player_names
        game = Game.new names, 3
        game.deal!
        assert_equal 3, game.players[0].face_up.size
        assert_equal 3, game.players[1].face_up.size
        assert_equal 3, game.players[2].face_up.size
    end

    def test_deal_deals_correct_amount_to_face_downs
        names = create_player_names
        game = Game.new names, 3
        game.deal!
        assert_equal 3, game.players[0].face_down.size
        assert_equal 3, game.players[1].face_down.size
        assert_equal 3, game.players[2].face_down.size
    end
    
    def test_deal_reduced_deck_size
        names = create_player_names
        game = Game.new names, 3
        game.deal!
        assert_equal (52-27), game.deck.size
    end
    
    def test_player_with_lowest_returns_lowest
        names = create_player_names
        game = Game.new names, 3
        game.players[0].hand.push Card.new 11, 4
        game.players[0].hand.push Card.new 5, 2
        game.players[1].hand.push Card.new 2, 1
        game.players[1].hand.push Card.new 9, 3
        game.players[2].hand.push Card.new 6, 2
        game.players[2].hand.push Card.new 4, 4
        result = game.player_with_lowest
        
        assert_equal 2, result 
    end

    def test_first_move_lays_cards
        names = create_player_names
        game = Game.new names, 3
        game.deal!
        pile_size_before = game.pile.size
        deck_size_before = game.deck.size
        game.first_move!

        assert pile_size_before < game.pile.size
        assert deck_size_before > game.deck.size
    end 

    def test_first_move_lays_both_if_same
        names = create_player_names
        game = Game.new names, 3
        eleven = Card.new 11, 4
        three = Card.new 3, 3
        another_three = Card.new 3, 1
        game.players[0].hand.push eleven
        game.players[0].hand.push three
        game.players[0].hand.push another_three
        game.players[1].hand.push Card.new 4, 2
        game.players[1].hand.push Card.new 5, 2
        game.players[1].hand.push Card.new 6, 2
        game.players[2].hand.push Card.new 7, 2
        game.players[2].hand.push Card.new 8, 2
        game.players[2].hand.push Card.new 9, 2

        game.first_move!

        assert game.pile.include? three
        assert game.pile.include? another_three
    end

    def test_play_from_hand_removes_from_hand
        names = create_player_names
        game = Game.new names, 3
        eleven = Card.new 11, 4
        two = Card.new 2, 3
        another_two = Card.new 2, 1
        game.players[0].hand.push eleven
        game.players[0].hand.push two
        game.players[0].hand.push another_two
        to_lay = Array.new
        to_lay.push two
        to_lay.push another_two
        game.play_from_hand! to_lay

        assert (not(game.players[0].hand.include? two))
        assert (not(game.players[0].hand.include? another_two))
    end

    def test_play_from_hand_adds_to_pile
        names = create_player_names
        game = Game.new names, 3
        eleven = Card.new 11, 4
        two = Card.new 2, 3
        another_two = Card.new 2, 1
        game.players[0].hand.push eleven
        game.players[0].hand.push two
        game.players[0].hand.push another_two
        to_lay = Array.new
        to_lay.push two
        to_lay.push another_two
        game.play_from_hand! to_lay

        assert game.pile.include? two
        assert game.pile.include? another_two
    end

    def test_play_from_hand_includes_card_in_last_move
        names = create_player_names
        game = Game.new names, 3
        eleven = Card.new 11, 4
        two = Card.new 2, 3
        another_two = Card.new 2, 1
        game.players[0].hand.push eleven
        game.players[0].hand.push two
        game.players[0].hand.push another_two
        to_lay = Array.new
        to_lay.push two
        to_lay.push another_two
        game.play_from_hand! to_lay

        assert game.last_move =~ /TWO of CLUBS/i
        assert game.last_move =~ /TWO of HEARTS/i
    end
       
end
