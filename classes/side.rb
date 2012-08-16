require 'chess'

class Side < Chess
  
  attr_accessor :color, :game, :direction, :pieces
  
  def initialize(params={})
    super
    @pieces ||= SidePieces.new
    @pieces.side = self
  end
  
  def square_piece(square)
    pieces.find { |piece| piece.square == square }
  end
  
  def remove_piece(piece)
    @pieces.delete(piece)
  end
  
  def any_moves?
    possible_moves.length > 0
  end
  
  def possible_moves
    piece_moves = Set.new
    pieces.each do |piece|
      piece.moves.each do |move|
        piece_moves << [piece, move]
      end
    end
    piece_moves
  end
  
  def make_a_random_move
    piece_moves = possible_moves.to_a
    piece_move = piece_moves[Random.rand(piece_moves.length)]
    @game.try_move(piece_move[0], piece_move[1])
  end
  
  class SidePieces < Set
    attr_accessor :side
    def <<(piece)
      raise 'Square already occupied' if @side.square_piece(piece.square)
      piece.side = @side
      super
    end
  end
      
end