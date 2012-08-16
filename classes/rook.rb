require 'chess'
require 'piece'

class Rook < Piece
  
  def ascii
    side_case 'r'
  end
  
end