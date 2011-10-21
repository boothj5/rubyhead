require './player.rb'
require './console.rb'

newlines 100

puts 'Welcome to RubyHead!'
newline
print 'Enter number of players: '
nplayers = gets.chomp.to_i
print 'Enter number of cards each: '
ncards = gets.chomp.to_i

puts "Players = #{nplayers}, Cards each = #{ncards}"

players = Array.new

(1..nplayers).each do |i|
    print "Enter name for player #{i}: "
    name = gets.chomp
    players.push Player.new name
end

players.each do |player|
    puts "Players name: #{player.name}"
end


