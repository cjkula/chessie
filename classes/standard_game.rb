require 'chess'
require 'game'

class StandardGame < Game
  
  def initialize(params={})
    super
    @board ||= StandardBoard.new
    @sides << Side.new(color: 'white', direction: 'north')
    @sides << Side.new(color: 'black', direction: 'south')
    setup_board
  end
  
  def setup_board
    @sides.each_with_index do |side, index|
      is_white = (index == 0)
      # pawns
      for column in 1..8 do
        side.pieces << Pawn.new(square: [column, is_white ? 2 : 7])
      end
      # aristocracy
      [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each.with_index do |cls, index|
        side.pieces <<  cls.new(square: [index + 1, is_white ? 1 : 8])
      end
    end
  end
  
  def try_move(piece, dest_square)
    return false unless super
    if pawn_on_last_rank?(piece)
      piece.promote(Queen) # sorry, no knights
    end
  end
  
  def pawn_on_last_rank?(piece)
    if piece.is_a?(Pawn) && piece.side
      row = piece.square.coordinates[1]
      if piece.side.direction == 'north'
        return true if row == 8
      else
        return true if row == 1
      end
    end
    false
  end
  
  def puts_board
    puts '+-----------------+'
    8.downto(1) do |row|
      text = '| '
      for col in 1..8
        piece = square_piece(Square.new([col, row]))
        text << (piece ? piece.ascii : ' ') << ' '
      end
      text << '|'
      puts text
    end
    puts '+-----------------+'
  end
    
end
