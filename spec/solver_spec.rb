require File.join(File.dirname(__FILE__),'..','solver.rb')

describe Solver do
  before do
    @s=Solver.new
  end
  describe '#available_pos' do
    describe 'when none to reverse' do
      it 'returns empty if all blocked' do
        @s.available_pos(['X']).should be_empty
        @s.available_pos(['XXX','XXX']).should be_empty
      end
      it 'returns empty if all block is empty' do
        @s.available_pos(['0000','0000','0000']).should be_empty
      end
      it 'returns empty if board is fullfilled' do
        @s.available_pos(['PPP','PEP','EEE']).should be_empty
      end
      it 'returns empty if could not reverse any enemys block' do
        @s.available_pos(['PP0']).should be_empty
        @s.available_pos(['EP0']).should be_empty
      end
    end
    describe 'when some reversible positions exists' do
      it 'should return horizontal availables' do
        @s.available_pos(['PE0']).should == [[2,0]]
        @s.available_pos(['PEE00P']).should == [[3,0]]
        @s.available_pos(['0EP0']).should == [[0,0]]
      end
      it 'should return vertical availables' do
        @s.available_pos(['P','E','0']).should == [[0,2]]
        @s.available_pos(['0','E','P']).should == [[0,0]]
      end
      it 'should return diagonal availables' do
        @s.available_pos(['P00','0E0','000']).should == [[2,2]]
        @s.available_pos(['000','0E0','00P']).should == [[0,0]]
        @s.available_pos(<<-B.split("\n").map(&:strip)).should == [[3,4]]
        0000
        0000
        0P00
        00E0
        0000
        B
        @s.available_pos(<<-B.split("\n").map(&:strip)).should == [[4,2]]
        00P00
        000E0
        00000
        B
        @s.available_pos(<<-B.split("\n").map(&:strip)).should == [[0,2]]
        00P00
        0E000
        00000
        B
      end
      it 'should return various availables' do
        pending
        @s.available_pos(<<-B.split("\n").map(&:strip)).sort_by{|a,b|a*1000+b}.should == [[1,2],[2,1],[2,2]]
        PP000
        PE000
        00000
        B
      end
    end
  end
end
