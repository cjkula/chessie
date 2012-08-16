require 'spec_helper'

describe "A square" do
  
  it "should accept a single coordinate" do
    square = Square.new([0])
    square[0].should be_a_kind_of(Integer)
  end
  
  it "should do algebraic translation" do
    square = Square.new([0])
    square.translate_from_algebraic('a1').should == [1, 1]
  end
  
  it "should accept an algebraic string" do
    Square.new('a1').coordinates.should == [1, 1]
    Square.new('d8').coordinates.should == [4, 8]
  end
    
  it "should accept integer values" do
    lambda {Square.new([100, 5])}.should_not raise_error
    lambda {Square.new([0, -20])}.should_not raise_error
    lambda {Square.new([-3, 0])}.should_not raise_error
  end
  
  it "should not accept nil values" do
    lambda {Square.new([nil, nil])}.should raise_error
    lambda {Square.new([1, nil])}.should raise_error
    lambda {Square.new([nil, 1])}.should raise_error
  end
  
  it "should not accept non-integer values" do
    lambda {Square.new([0, 'one'])}.should raise_error
    lambda {Square.new([[1, 2, 3], 8])}.should raise_error
  end
  
  it "should evaluate two squares with identical coordinates as being equal" do
    square_a = Square.new([1, 2, 3])
    square_b = Square.new([1, 2, 3])
    square_a.should == square_b
  end
  
  it "should evaluate two squares with different numbers of dimensions as being unequal" do
    square_a = Square.new([1, 2])
    square_b = Square.new([1, 2, 3])
    square_a.should_not == square_b
  end
  
  it "should evaluate two squares with different coordinates as being unequal" do
    square_a = Square.new([1, 2])
    square_b = Square.new([1, 3])
    square_a.should_not == square_b
  end
  
end
  
