require 'chess'
require 'piece'

class Queen < Piece
  
  def ascii
    side_case 'q'
  end
  
end