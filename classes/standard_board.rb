require 'chess'
require 'board'

class StandardBoard < Board
  
  def initialize(params={})
    params[:dimensions] = [(1..8), (1..8)]
    super
  end
  
end