require 'spec_helper'

describe 'A pawn' do
  
  before(:each) do
    @game = StandardGame.new
    @white = @game.sides[0]
    @black = @game.sides[1]
  end
  
  it "should return a list of possible moves" do
    @game.square_piece('a2').moves.should be_a_kind_of(Set)
    @game.square_piece('d7').moves.should be_a_kind_of(Set)
  end

  it "should be able to move straight forward one or two spaces from its starting position" do
    set_of_coordinates(@game.square_piece('b2').moves).should == set_of_coordinates(['b3', 'b4'])
    set_of_coordinates(@game.square_piece('h7').moves).should == set_of_coordinates(['h6', 'h5'])
  end
  
  it "should only be able to move straight forward a single space from somewhere other than start position" do
    b3 = Pawn.new(square: 'b3', starting_square: 'a1')
    @white.pieces << b3
    h5 = Pawn.new(square: 'h5', starting_square: 'h8')
    @black.pieces << h5
    set_of_coordinates(b3.moves).should == set_of_coordinates(['b4'])
    set_of_coordinates(h5.moves).should == set_of_coordinates(['h4'])
  end
  
  it "should not be able to move if no pieces to attack and blocked straight ahead by own side" do
    @white.pieces << Pawn.new(square: 'b3')
    @black.pieces << Pawn.new(square: 'e6')
    @game.square_piece('b2').moves.should == Set.new
    @game.square_piece('e7').moves.should == Set.new   
  end

  it "should not be able to move if no pieces to attack and blocked straight ahead by different side" do
    @black.pieces << Pawn.new(square: 'b3')
    @white.pieces << Pawn.new(square: 'e6')
    @game.square_piece('b2').moves.should == Set.new
    @game.square_piece('e7').moves.should == Set.new   
  end

  it "should be able to attack on the diagonal" do
    @black.pieces << Pawn.new(square: 'b3') << Pawn.new(square: 'd3')
    @white.pieces << Pawn.new(square: 'e6')
    set_of_coordinates(@game.square_piece('c2').moves).should == set_of_coordinates(['b3', 'c3', 'c4', 'd3'])
    set_of_coordinates(@game.square_piece('d7').moves).should == set_of_coordinates(['e6', 'd6', 'd5'])
  end
  
end