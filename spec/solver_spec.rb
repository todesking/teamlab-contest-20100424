require File.join(File.dirname(__FILE__),'..','solver.rb')

describe Solver do
  before do
    @s=Solver.new
  end
  describe '#available_pos' do
    it 'returns empty if all blocked' do
      @s.available_pos(['X']).should be_empty
      @s.available_pos(['XXX','XXX']).should be_empty
    end
    it 'returns empty if none to reverse(case: all empty board)' do
      @s.available_pos(['0000','0000','0000']).should be_empty
    end
  end
end
