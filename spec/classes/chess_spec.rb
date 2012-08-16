require 'spec_helper'

describe "Chess chess class" do
  
  it "should set instance variables using hash notation" do
    chess = Chess.new
    (chess[:a] = 'value').should == 'value'
    chess.instance_variable_get('@a').should == 'value'
  end
  
  it "should retrieve instance variables using hash notation" do
    chess = Chess.new
    chess.instance_variable_set '@b', 'value2'
    chess[:b].should == 'value2'
  end
  
  it "should initialize argument param hash into instance variables" do
    init = Hash.new(a: 1, b: 'two', c: [3], d: {four: 4})
    chess = Chess.new init
    init.each_pair do |key, value|
      chess[key].should == value
    end
  end
  
end