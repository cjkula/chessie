require 'chess'

class Board < Chess
  
  attr_accessor :dimensions
  
  def initialize(params={})
    super
  end
  
  def valid_square?(square)
    coords = square.coordinates
    return false unless coords.length == dimensions.length
    coords.each_with_index do |coord, index|
      return false unless (dimensions[index]).member?(coords[index])
    end
    true
  end
  
  def relative_square(square, offset, direction='north')
    raise 'Invalid direction' unless direction=='north' || direction=='south'
    coords = square.coordinates
    raise 'Wrong number of dimensions' unless coords.length == offset.length
    sum_coords = []
    coords.each_with_index do |coord, index|
      sum_coords << coord + ((direction=='north') ? offset[index] : -offset[index])
    end
    result = Square.new(sum_coords)
    valid_square?(result) ? result : nil
  end
  
end