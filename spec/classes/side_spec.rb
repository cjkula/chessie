require 'spec_helper'

describe "A side" do
  
  before(:each) do
    @game = Game.new
    @white = Side.new(
      color:     'white',
      direction: 'north'
    )
    @black = Side.new(
      color:     'black',
      direction: 'south'
    )
  end
  
  it "should be able to reference a game" do
    @game.sides << @white << @black
    @white.game.should == @game
    @black.game.should == @game
  end
  
  it "should accept a color" do
    @white.color.should == 'white'
    @black.color.should == 'black'
  end
  
  it "should accept a direction of play" do
    @white.direction.should == 'north'
    @black.direction.should == 'south'
  end
  
  it "should start with an empty list of pieces" do
    @white.pieces.should == Set.new
  end
  
  it "should be able to add pieces" do
    piece1 = Piece.new(square: [1, 1])
    piece2 = Piece.new(square: [8, 8])
    @white.pieces << piece1
    @white.pieces << piece2
    @white.pieces.include?(piece1).should be_true
    @white.pieces.include?(piece2).should be_true
  end
  
  it "should be able to remove pieces" do
    piece = Piece.new(square: [3, 8])
    @white.pieces << piece
    @white.pieces.include?(piece).should be_true
    @white.remove_piece(piece)
    @white.pieces.include?(piece).should be_false
  end
  
  it "should return nil when queried on a square that the side does not occupy" do
    @white.square_piece(Square.new([1, 1])).should be_nil
  end
  
  it "should return the piece when queried on a square that the side occupies" do
    square = Square.new([1, 1])
    piece = Piece.new(square: square)
    @white.pieces << piece
    @white.square_piece(square).should == piece
  end
  
  it "should error if adding a piece to a square that is already occupied" do
    @white.pieces << Piece.new(square: [1, 1])
    lambda {
      @white.pieces << Piece.new(square: [1, 1])
    }.should raise_error
  end
  
  it "should be able to make a random move" do
    game = StandardGame.new
    game.should_receive(:try_move)
    game.sides[0].make_a_random_move
  end
  
  it "should be able to report if it has any moves" do
    game = StandardGame.new
    game.sides[0].any_moves?.should be_true
  end
  
  it "should be able to report that it has no moves" do
    game = Game.new
    game.board = StandardBoard.new
    side = Side.new(direction: 'north')
    game.sides << side
    side.pieces << Pawn.new(square: 'a8')
    side.any_moves?.should be_false
  end
    
end