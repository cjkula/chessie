require 'spec_helper'

describe "A board" do
  
  before(:each) do
    @standard = Board.new(dimensions: [1..8, 1..8])
  end
  
  it "should accept a list of ranges of board dimensions" do
    @standard.dimensions[0].should == (1..8)
    @standard.dimensions[1].should == (1..8)    
  end
    
  it "should validate that a square has the same number of dimensions as the board" do
    @standard.valid_square?(Square.new([1, 1])).should be_true
    @standard.valid_square?(Square.new([1])).should be_false
    @standard.valid_square?(Square.new([1, 1, 1])).should be_false
  end
  
  it "should validate that a square is within the board dimensions" do
    @standard.valid_square?(Square.new([1, 1])).should be_true
    @standard.valid_square?(Square.new([1, 8])).should be_true
    @standard.valid_square?(Square.new([8, 1])).should be_true
    @standard.valid_square?(Square.new([8, 8])).should be_true
  end

  it "should invalidate that a square is outside the board dimensions" do
    @standard.valid_square?(Square.new([0,0])).should be_false
    @standard.valid_square?(Square.new([1,9])).should be_false
  end
  
  it "should return a square representing a relative distance from a given square" do
    @standard.relative_square(Square.new([1, 1]), [1, 0]).should == Square.new([2, 1])
    @standard.relative_square(Square.new([4, 4]), [0, 2]).should == Square.new([4, 6])
    @standard.relative_square(Square.new([8, 2]), [-4, -1]).should == Square.new([4, 1])
  end
  
  it "should return nil if the resulting square is out of range of the board" do
    @standard.relative_square(Square.new([1, 1]), [-1, 0]).should be_nil
    @standard.relative_square(Square.new([1, 1]), [0, -1]).should be_nil
    @standard.relative_square(Square.new([8, 8]), [0, 1]).should be_nil
    @standard.relative_square(Square.new([8, 8]), [1, 0]).should be_nil
  end
  
  it "should error if a relative offset has the wrong number of dimensions" do
    lambda {
      @standard.relative_square(Square.new([1, 1]), [1])     
    }.should raise_error
  end
    
end