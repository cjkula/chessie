require 'spec_helper'

describe "A piece" do
  
  it "should be assignable to a square" do
    Piece.new(square: Square.new([0, 0])).square.should be_a_kind_of(Square)
  end
  
  it "should take shorthand for assigning to a square" do
    Piece.new(square: [0, 0]).square.should be_a_kind_of(Square)
  end
  
  it "should raise an error if not assigned to a square" do
    lambda {
      Piece.new
    }.should raise_error
  end
  
  it "should contain a backreference to the side of the piece" do
    side = Side.new
    piece = Piece.new(square: [0, 0])
    side.pieces << piece
    piece.side.should == side
  end
  
  it "should be able to be removed from its assigned side" do
    side = Side.new
    piece = Piece.new(square: [1, 1])
    side.pieces << piece
    side.pieces.length.should == 1
    piece.remove
    side.pieces.length.should == 0
  end
  
  it "should return an empty list of possible moves" do
    Piece.new(square: [1, 1]).moves.should == Set.new
  end
  
  it "should be able to be moved" do
    piece = Piece.new(square: [3, 3])
    move = Square.new([4, 4])
    piece.move_to(move)
    piece.square.should == move
  end
  
  it "should request permission from the game to make a move" do
    game = Game.new
    side = Side.new
    game.sides << side
    piece = Piece.new(square: [3, 3])
    side.pieces << piece
    move = Square.new([4, 4])
    game.should_receive(:try_move)
    piece.try_move(move)
  end
  
  it "should save and remember its initial square" do
    piece = Piece.new(square: [1, 2])
    piece.starting_square.should == Square.new([1, 2])
    piece.move_to([8, 8])
    piece.starting_square.should == Square.new([1, 2])
  end
  
  it "should be able to promote a piece" do
    @game = Game.new
    side = Side.new
    @game.sides << side
    piece = Piece.new(square: 'a8', starting_square: 'a2')
    side.pieces << piece
    promoted = piece.promote(Queen)
    promoted.should be_a_kind_of(Queen)
    promoted.square.should == Square.new('a8')
    promoted.starting_square.should == Square.new('a2')
  end
    
end