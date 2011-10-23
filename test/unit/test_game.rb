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
end
