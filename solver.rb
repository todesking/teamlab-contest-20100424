
class Solver
  def solve board,reversible
    return [:put,[1,1]]
  end
  def available_pos board
    result=[]
    each_horizonal(board) {|line,y|
      match=/0E+P|PE+0/.match(line)
      unless match.nil?
        match.length.times{|i|
          result.push match[i][0]=='0'[0] ? [match.begin(i),y] : [match.end(i)-1,y]
        }
      end
    }
    result
  end
  def each_horizonal board
    board.each_with_index{|line,y| yield line,y}
  end
end
