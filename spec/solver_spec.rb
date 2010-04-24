require File.join(File.dirname(__FILE__),'..','solver.rb')

describe Solver do
  before do
    @s=Solver.new
  end
  it '#available_pos returns all available positions to put' do
    @s.available_pos(['X']).should be_empty
  end
end
