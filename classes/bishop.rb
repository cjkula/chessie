require 'chess'
require 'piece'

class Bishop < Piece
  
  def ascii
    side_case 'b'
  end
  
end