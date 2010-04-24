
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
    each_vertical(board) {|line,x|
      match=/0E+P|PE+0/.match(line)
      unless match.nil?
        match.length.times{|i|
          result.push match[i][0]=='0'[0] ? [x,match.begin(i)] : [x,match.end(i)-1]
        }
      end
    }
    result
  end
  def each_horizonal board
    board.each_with_index{|line,y| yield line,y}
  end
  def each_vertical board
    board.first.length.times{|x|
      line=""
      board.length.times{|y|
        line+=board[y][x,x+1]
      }
      yield line,x
    }
  end
end
