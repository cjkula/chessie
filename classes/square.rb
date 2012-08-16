require 'chess'

class Square < Chess
    
    attr_accessor :coordinates
    
    def initialize(coords)
      @coordinates = coords.is_a?(String) ? translate_from_algebraic(coords) : coords
      @coordinates.each_with_index do |coord, index|
        @coordinates[index] = Integer(@coordinates[index])
      end
    end
        
    def []=(dimension, value)
      if dimension.is_a?(Integer)
        @coordinates[dimension] = Integer(value)
      else
        super
      end
    end

    def [](dimension)
      if dimension.is_a?(Integer)
        @coordinates[dimension]
      else
        super
      end
    end
    
    def ==(square)
      square = Square.new(square) unless square.is_a?(Square)
      coordinates == square.coordinates
    end
    
    def translate_from_algebraic(string)
      string.strip.tr('a-h', '1-8').tr('A-H', '1-8').split(//).map { |char| char.to_i }
    end
    
end