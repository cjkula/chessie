require 'spec_helper'

describe "A game" do
  
  before(:each) do
    @game = Game.new
  end
  
  it "should have a list of sides" do
    @game.sides.should be_a_kind_of(Array)
  end
  
  it "should be able to add a side" do
    @game.sides << Side.new
    @game.sides.length.should == 1
  end
  
  it "should add a backreference to the game when adding a side" do
    side = Side.new
    @game.sides << side
    side.game.should == @game
  end
  
  it "should be able to add a board" do
    @game.board = StandardBoard.new
    @game.board.should be_a_kind_of(Board)
  end
  
  it "should return nil when queried on an empty square" do
    @game.board = StandardBoard.new
    @game.square_piece(Square.new([1, 1])).should be_nil
  end
  
  it "should error when queried on an invalid square" do
    @game.board = StandardBoard.new
    lambda {
      @game.square_piece(Square.new([0, 0]))
    }.should raise_error
  end

  it "should return the piece when queried on an occupied square" do
    @game.board = StandardBoard.new
    side1 = Side.new
    side2 = Side.new
    @game.sides << side1 << side2
    square1 = Square.new([1, 1])
    square2 = Square.new([8, 8])
    piece1 = Piece.new(square: square1)
    piece2 = Piece.new(square: square2)
    side1.pieces << piece1
    side2.pieces << piece2
    @game.square_piece(square1).should == piece1
    @game.square_piece(square2).should == piece2
  end
  
  it "should return a piece using algebraic notation" do
    @game.board = StandardBoard.new
    side = Side.new
    @game.sides << side
    piece = Piece.new(square: 'a1')
    side.pieces << piece
    @game.square_piece('a1').should == piece
  end
  
  it "should return the side of a piece on a square" do
    @game.board = StandardBoard.new
    side = Side.new
    @game.sides << side
    side.pieces << Piece.new(square: 'b5')
    @game.square_side('b5').should == side
  end
  
  it "should return nil for the side of an empty square" do
    @game.board = StandardBoard.new
    @game.square_side('b5').should be_nil
  end
  
  it "start a round counter at zero" do
    @game.round.should == 0
  end
  
  it "should start a turn counter at zero" do
    @game.turn.should == 0
  end
  
  it "should advance the turn counter when turn completed" do
    @game.sides << Side.new << Side.new
    @game.turn_completed
    @game.turn.should == 1
    @game.round.should == 0
  end
  
  it "should advance the round counter when all turns completed" do
    @game.sides << Side.new << Side.new
    @game.turn_completed
    @game.turn_completed
    @game.turn.should == 0
    @game.round.should == 1
  end
  
  it "should return the side whose move it currently is" do
    side1 = Side.new
    side2 = Side.new
    @game.sides << side1 << side2
    @game.side_to_move.should == side1
    @game.turn_completed
    @game.side_to_move.should == side2
    @game.turn_completed
    @game.side_to_move.should == side1    
  end
  
  it "should be able to promote a piece" do
    @game.board = StandardBoard.new
    side = Side.new
    @game.sides << side
    piece = Piece.new(square: 'a8')
    side.pieces << piece
    piece.promote(Queen)
    @game.square_piece('a8').should be_a_kind_of(Queen)
  end
      
end