require File.join(File.dirname(__FILE__),'..','solver.rb')

describe Solver do
  before do
    @s=Solver.new
  end
  describe '#available_pos' do
    describe 'none to reverse' do
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
  end
end
