
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
    each_diagonal_right(board) {|line,x,y|
      p [line,x,y]
      match=/0E+P|PE+0/.match(line)
      unless match.nil?
        match.length.times{|i|
          result.push match[i][0]=='0'[0] ? [x,y+match.begin(i)] : [x+match.end(i)-1,y+match.end(i)-1]
        }
      end
    }
    each_diagonal_left(board) {|line,x,y|
      p [line,x]
      match=/0E+P|PE+0/.match(line)
      unless match.nil?
        match.length.times{|i|
          result.push match[i][0]=='0'[0] ? [x,y+match.begin(i)] : [x,y-match.end(i)-1]
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
  def each_diagonal_right board
    return if width(board)<3 || height(board)<3
    # \ (upper)
    (0...width(board)-2).each{|x|
      p ['dig-right',x]
      line=''
      (0...[width(board),height(board)].min).each{|i|
        line+=board[i][x+i,x+i+1]
      }
      yield line,x,0
    }
    # \ (downer)
    (0...height(board)-2).each{|y|
      line=''
      (0..y).each{|x|
        line+=board[y][x,x+1]
      }
      yield line,0,y
    }
  end
  def each_diagonal_left board
    return if width(board)<3 || height(board)<3
    # /(upper)
    (width(board)-1...2).each{|x|
      line=''
      (0..x).each{|y|
        line+=board[y][x,x+1]
      }
      yield line,x,0
    }
    (0..(height(board)-2)).each{|y|
      line=''
      (width(board)-1...y).each{|x|
        line+=board[y][x,x+1]
      }
      yield line,0,y
    }
  end
  def width(board)
    board.first.length
  end
  def height(board)
    board.length
  end
end
