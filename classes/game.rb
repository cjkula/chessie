require 'chess'

class Game < Chess
  
  attr_accessor :board, :sides, :round, :turn
  
  def initialize(params={})
    super
    @sides = GameSides.new
    @sides.game = self
    @round = 0    # tracks complete rounds of play completed (all sides)
    @turn = 0     # turn will reset to zero after each round
  end
  
  def square_piece(square)
    return nil unless @board
    square = Square.new(square) if square.is_a?(String) || square.is_a?(Array)
    raise 'Invalid board square' unless @board.valid_square?(square)
    @sides.each do |side|
      piece = side.square_piece(square)
      return piece if piece
    end
    nil
  end
  
  def square_side(square)
    piece = square_piece(square)
    piece ? piece.side : nil
  end
  
  def turn_completed
    @turn += 1
    if @turn == @sides.length
      @turn = 0
      @round += 1
    end
  end
  
  def side_to_move
    @sides[@turn]
  end
  
  def try_move(piece, dest_square)
    dest_side = square_side(dest_square)
    if dest_side == piece.side
      false
    else
      if dest_side
        square_piece(dest_square).remove
      end
      piece.move_to(dest_square)
      turn_completed
      true
    end
  end
  
  class GameSides < Array
    attr_accessor :game
    def <<(side)
      super(side)
      side.game = @game
      self
    end
  end

end