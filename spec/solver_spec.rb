require File.join(File.dirname(__FILE__),'..','solver.rb')

describe Solver do
end

describe Solver::Board do
  def when_board_is b
    @board=Solver::Board.new b,0
  end
  describe '#w' do
    subject { @board.w }
    it 'should return width of the board' do
      when_board_is [ '000' ]
      should == 3
    end
  end
  describe '#h' do
    subject { @board.h }
    it 'should return height of board' do
      when_board_is [ '000' ]
      should == 1
    end
  end
  describe '#self[]' do
    it 'should return cell state of the position' do
      when_board_is [ '000', 'PEP' ]
      @board[0,0].should == '0'
      @board[1,1].should == 'E'
      @board[-1,0].should == 'X'
      @board[0,-1].should == 'X'
      @board[3,0].should == 'X'
      @board[0,2].should == 'X'
    end
  end
  describe '#reversible_count' do
    it 'should return ひっくりかえせる駒の数' do
      when_board_is %w(
        00000
        0EEE0
        0EPE0
        0EEE0
        00000
      )
      @board.reversible_count(0,1).should == 0
      @board.reversible_count(2,2).should == 0
      @board.reversible_count(0,0).should == 1
      @board.reversible_count(4,0).should == 1
      @board.reversible_count(0,4).should == 1
      @board.reversible_count(4,4).should == 1
      @board.reversible_count(2,0).should == 1
      @board.reversible_count(0,2).should == 1
      @board.reversible_count(2,4).should == 1
      @board.reversible_count(4,2).should == 1

      when_board_is %w(
      00000000
      00000000
      0000E000
      000EE000
      000PE000
      00000000
      00000000
      00000000
      )
      @board.reversible_count(1,2).should == 0
      @board.reversible_count(5,4).should == 1
    end
  end
  describe '#possible_pos' do
    subject { @board.possible_pos }
    it 'should return possible positions for next turn'do
      when_board_is ['PE0']
      should == [ {:pos=>[2,0],:count=>1} ]
    end
  end
end
