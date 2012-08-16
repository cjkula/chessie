require File.join(File.dirname(__FILE__), '../setup.rb')

def set_of_coordinates(squares)
  set = Set.new
  squares.each do |square|
    square = Square.new(square) unless square.is_a?Square
    set << square.coordinates
  end
  set
end