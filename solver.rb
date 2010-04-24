
class Solver
  def solve board,reversible
    if reversible==1 && rand < 0.4
      return [:reverse]
    end
    availables=available_pos(board).sort_by{|pos|score(board,pos)}
    puts 'availables: '+availables.inspect
    return [:put,availables.first]
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
  def score(board,pos)
    info=get_info(board,pos)
    return info[:X]*0.3+info[:P]*-0.1+rand
  end
  def get_info board,pos
    blank=0
    player=0
    enemy=0
    block=0
    dirs=[[-1,0],[1,0],[0,-1],[0,1],[1,1],[1,-1],[-1,1],[-1,-1]]
    dirs.each{|dir|
      case block_at(board,[pos[0]+dir[0],pos[1]+dir[1]])
      when 'X'
        block+=1
      when 'E'
        enemy+=1
      when 'P'
        player+=1
      when '0'
        blank+=1
      end
    }
    return :blank=>blank,:P=>player,:E=>enemy,:X=>block
  end
  def block_at board,pos
    return 'X' if pos[0] < 0 || width(board)<=pos[1]
    return 'X' if pos[1] < 0 || height(board)<=pos[1]
    return board[pos[1]][pos[0],1]
  end
  def each_horizonal board
    board.each_with_index{|line,y| yield line,y}
  end
  def each_vertical board
    board.first.length.times{|x|
      line=''
      board.length.times{|y|
        line+=board[y][x,1]
      }
      yield line,x
    }
  end
  def each_diagonal_right board
    return if width(board)<3 || height(board)<3
    # \ (upper)
    (0...width(board)-2).each{|x|
      line=''
      (0...[width(board)-x,height(board)-x].min).each{|i|
        line+=board[i][x+i,1]
      }
      yield line,x,0
    }
    # \ (downer)
    (0...height(board)-2).each{|y|
      line=''
      (0..y).each{|x|
        line+=board[y][x,1]
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
        line+=board[y][x,1]
      }
      yield line,x,0
    }
    (0..(height(board)-2)).each{|y|
      line=''
      (width(board)-1...y).each{|x|
        line+=board[y][x,1]
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
