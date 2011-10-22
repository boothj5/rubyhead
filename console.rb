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
        puts "Players : #{player.name}"
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
        print 'FACE DOWN : '
        player.face_down.each do |card|
            print "#{card}, "
        end
        newlines 2
    end
end



