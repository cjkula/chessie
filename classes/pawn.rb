require 'chess'
require 'piece'

class Pawn < Piece
  
  def ascii
    side_case 'p'
  end
  
  def moves
    return nil unless @side
    game = @side.game
    board = game.board
    direction = @side.direction
    
    forward_one = board.relative_square(@square, [0, 1], direction)
    attack_left = board.relative_square(@square, [-1, 1], direction)
    attack_right = board.relative_square(@square, [1, 1], direction)
    
    possible_moves = Set.new
    
    if forward_one && game.square_side(forward_one).nil?
      possible_moves << forward_one
      forward_two = board.relative_square(@square, [0, 2], direction)
      if forward_two && (self.square == self.starting_square) && game.square_side(forward_two).nil?
        possible_moves << forward_two
      end
    end
    
    if attack_left
      dest_side = game.square_side(attack_left)
      if dest_side && (dest_side != @side)
        possible_moves << attack_left
      end
    end
      
    if attack_right
      dest_side = game.square_side(attack_right)
      if dest_side && (dest_side != @side)
        possible_moves << attack_right
      end
    end
    
    possible_moves
  end
  
end