require 'spec_helper'

describe "A board" do
  
  before(:each) do
    @standard = StandardBoard.new
  end
  
  it "should have standard dimensions" do
    @standard.dimensions[0].should == (1..8)
    @standard.dimensions[1].should == (1..8)    
  end
  
end
