def newline
    puts 
end

def newlines n
    n.times do
        newline
    end
end

def clearscreen
    newlines 100
end

def show_welcome_msg
    puts 'Welcome to Rubyhead!'
    newline
end

def request_num_players
    print 'Enter number of players : '
    gets.chomp.to_i
end

def request_num_cards
    print 'Enter number of cards each : '
    gets.chomp.to_i
end

def request_player_names n
    player_names = Array.new
    (1..n).each do |i|
        print "Enter name for player #{i}: "
        name = gets.chomp
        player_names.push name
    end
    return player_names
end

def show_game game
    puts "#{game.deck.size} left on deck"
    newline

    game.players.each do |player|
        show_player player, true
        newlines 1
    end
end

def show_player player, include_face_down
    puts "Player : #{player.name}"
    print 'HAND      : '
    player.hand.each do |card|
        print "#{card}, "
    end
    newlines 1
    print 'FACE UP   : '
    player.face_up.each do |card|
        print "#{card}, "
    end
    newlines 1
    if include_face_down
        print 'FACE DOWN : '
        player.face_down.each do |card|
            print "#{card}, "
        end
        newlines 1
    end
end

def request_swap name
    print "#{name}, would you like to swap cards?"
    (gets.chomp.downcase == "y") ? true : false
end

def request_swap_more
    print 'Would you like to swap more cards? '
    (gets.chomp.downcase == "y") ? true : false
end

def request_hand_swap num_cards
    print "Choose a hand card (1-#{num_cards}): "
    gets.chomp.to_i - 1

end

def request_face_up_swap num_cards
    print "Choose a face up card (1-#{num_cards}): "
    gets.chomp.to_i - 1
end






