require 'chess'
require 'piece'

class King < Piece
  
  def ascii
    side_case 'k'
  end
  
end