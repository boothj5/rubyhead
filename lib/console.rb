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
    show_pile game.pile
    newline
    puts "#{game.deck.size} left on deck"
    newline
    puts "#{game.burnt.size} burnt"
    newline

    game.players.each do |player|
        show_player(player, true)
        newline
    end

    puts game.last_move
    newline
end

def show_hand(name, cards, hide)
    print name
    cards.each do |card|
        if hide
            print "****"
        else
            print "(#{(cards.index card) + 1})#{card}"
        end
        unless ((cards.index card) == (cards.length - 1))
            print ', '
        end
    end
    newline
end

def show_player(player, include_face_down)
    puts "Player : #{player.name}"
    show_hand('HAND      : ', player.hand, false)
    show_hand('FACE UP   : ', player.face_up, false)
    if include_face_down
        show_hand('FACE DOWN : ', player.face_down, true)
    end
end

def show_pile pile
    puts "#{pile.size} on pile:"
    reverse_pile = pile.reverse
    first = true
    reverse_pile.each do |card|
        if first
            puts " (*)#{card}"  
            first = false
        else
            puts "    #{card}"
        end
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

def request_move player
    print "#{player.name}, choose cards to lay: "
    gets.chomp.split(',').map { |ch| ch.to_i - 1}
end

def show_pickup_msg name
    print "Oh dear #{name}, you must pickup, press enter."
    wait_user
end

def show_bad_move
    print "Thats an invalid move, press enter to continue."
    wait_user
end

def wait_user
    gets
end

def request_face_down_card name
    print "#{name} please choose a face down card: "
    gets.chomp.to_i - 1
end

def show_face_down_fail card
    print "OH DEAR! You chose the #{card}, press enter to continue."
    wait_user
end

def show_face_down_win card
    print "WHEW! You chose the #{card}, press enter to continue."
    wait_user
end

def show_rubyhead name
    newline
    puts "!!!!!GAME OVER!!!!!"
    puts "#{name} is a SHITHEAD!"
end
