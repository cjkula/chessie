require "#{File.dirname(__FILE__)}/setup"

# create a game and have it play itself

game = StandardGame.new

puts "\nBegin autoplay game"
puts "\nINITIAL BOARD"
game.puts_board

while true do
  moving_side = game.side_to_move
  break unless moving_side.any_moves?
  puts "\nRound #{game.round + 1}, #{moving_side.color} moves:"
  moving_side.make_a_random_move
  game.puts_board
end

puts "\nGAME OVER"
