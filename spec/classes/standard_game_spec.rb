require 'spec_helper'

describe "A standard game" do
  
  before(:each) do
    @game = StandardGame.new
  end
  
  it "should have two sides" do
    @game.sides.length.should == 2
  end
  
  it "should have a white and black side" do
    @game.sides[0].color.should == 'white'
    @game.sides[1].color.should == 'black'
  end
  
  it "should set the direction of each side" do
    @game.sides[0].direction.should == 'north'
    @game.sides[1].direction.should == 'south'    
  end
  
  it "should come with a standard board" do
    @game.board.should be_a_kind_of(StandardBoard)
  end
  
  it "should place pawns for both sides" do
    for column in 1..8 do
      white_pawn = @game.square_piece(Square.new([column, 2]))
      white_pawn.should be_a_kind_of(Pawn)
      white_pawn.side.color.should == 'white'
      black_pawn = @game.square_piece(Square.new([column, 7]))
      white_pawn.should be_a_kind_of(Pawn)
      black_pawn.side.color.should == 'black'
    end
  end

  it "should place kings for both sides" do
    white_king = @game.square_piece('e1')
    white_king.should be_a_kind_of(King)
    white_king.side.color.should == 'white'
    black_king = @game.square_piece('e8')
    black_king.should be_a_kind_of(King)
    black_king.side.color.should == 'black'
  end
    
  it "should place queens for both sides" do
    white_queen = @game.square_piece('d1')
    white_queen.should be_a_kind_of(Queen)
    white_queen.side.color.should == 'white'
    black_queen = @game.square_piece('d8')
    black_queen.should be_a_kind_of(Queen)
    black_queen.side.color.should == 'black'
  end
  
  it "should place rooks for both sides" do
    [1, 8].each do |column|
      white_rook = @game.square_piece(Square.new([column, 1]))
      white_rook.should be_a_kind_of(Rook)
      white_rook.side.color.should == 'white'
      black_rook = @game.square_piece(Square.new([column, 8]))
      black_rook.should be_a_kind_of(Rook)
      black_rook.side.color.should == 'black'
    end
  end

  it "should place knights for both sides" do
    [2, 7].each do |column|
      white_knight = @game.square_piece(Square.new([column, 1]))
      white_knight.should be_a_kind_of(Knight)
      white_knight.side.color.should == 'white'
      black_knight = @game.square_piece(Square.new([column, 8]))
      black_knight.should be_a_kind_of(Knight)
      black_knight.side.color.should == 'black'
    end
  end
  
  it "should place bishops for both sides" do
    [3, 6].each do |column|
      white_bishop = @game.square_piece(Square.new([column, 1]))
      white_bishop.should be_a_kind_of(Bishop)
      white_bishop.side.color.should == 'white'
      black_bishop = @game.square_piece(Square.new([column, 8]))
      black_bishop.should be_a_kind_of(Bishop)
      black_bishop.side.color.should == 'black'
    end
  end
  
  it "should be able to print the board to stdio" do
    lambda {
      @game.puts_board
    }.should_not raise_error
  end
  
  it "should promote a pawn when it reaches the last rank without attacking" do
    white = @game.sides[0]
    @game.square_piece('a7').remove
    @game.square_piece('a8').remove
    pawn = Pawn.new(square: Square.new('a7'))
    white.pieces << pawn
    pawn.try_move(Square.new('a8'))
    @game.square_piece('a8').should be_a_kind_of(Queen)
  end

  it "should not promote a pawn if it has not reached the last rank" do
    white_pawn = @game.square_piece('c2')
    white_pawn.try_move(Square.new('c3'))
    @game.square_piece('c3').should == white_pawn
    black_pawn = @game.square_piece('g7')
    black_pawn.try_move(Square.new('g5'))
    @game.square_piece('g5').should == black_pawn
  end

  it "should promote a pawn when it reaches the last rank in an attack" do
    black = @game.sides[1]
    @game.square_piece('a2').remove
    pawn = Pawn.new(square: Square.new('a2'))
    black.pieces << pawn
    pawn.try_move(Square.new('b1'))
    @game.square_piece('b1').should be_a_kind_of(Queen)
  end
    
end