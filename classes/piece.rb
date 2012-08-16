require 'chess'
require 'set'

class Piece < Chess
  
  attr_accessor :square, :side, :starting_square
  
  def initialize(params={})
    super
    raise 'Piece has not been assigned to a square' unless @square
    @square = Square.new(@square) unless @square.is_a?(Square)
    if @starting_square
      @starting_square = Square.new(@starting_square) unless @starting_square.is_a?(Square)
    end
    @starting_square ||= @square.clone
  end
  
  def moves
    Set.new  # a generic piece has no capabilities
  end
  
  def try_move(dest_square)
    if @side && @side.game
      @side.game.try_move(self, dest_square)
    else
      move_to(dest_square)
      true
    end
  end
  
  def move_to(square)
    @square = square
  end
  
  def remove
    @side.remove_piece(self) if @side
  end
  
  def promote(new_class)
    if @side
      params = {
        square: @square,
        side: @side,
        starting_square: @starting_square
      }
      self.remove
      new_piece = new_class.new(params)
      @side.pieces << new_piece if @side
      new_piece
    else
      nil
    end
  end
  
  def ascii
    side_case 'x'
  end
  
  def side_case(char)
    if @side && @side.game && (@side.game.sides[0] != @side) # not the first side to play
     char.tr('A-Z', 'a-z')
    else
     char.tr('a-z', 'A-Z')
    end
  end
    
end