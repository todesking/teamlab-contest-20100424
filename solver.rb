
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
    []
  end
  def score(board,pos)
    0
  end
  def get_info board,pos
    blank=0
    player=0
    enemy=0
    block=0
    return :blank=>blank,:P=>player,:E=>enemy,:X=>block
  end
  class Board
    def initialize board,reversible
      @board=board
      @reversible=reversible
    end
    def w
      @board.first.length
    end
    def h
      @board.length
    end
    def [](x,y)
      return 'X' unless (0...w).include? x
      return 'X' unless (0...h).include? y
      return @board[y][x,1]
    end
    def possible_pos
      possibles=[]
      (0...w).each{|x|
        (0...h).each{|y|
          next unless self[x,y]=='0'
          possibles.push [x,y] if reversible_count(x,y)>0
        }
      }
      return possibles
    end
    def reversible_count x,y
      return 0 unless self[x,y] == '0'
      count=0
      [
        [-1,0],
        [1,0],
        [0,-1],
        [0,1],
        [1,1],
        [1,-1],
        [-1,1],
        [-1,-1]
      ].each{|dx,dy|
        i=1
        begin
          i+=1
        end while self[x+i*dx,y+i*dy] == 'E'
        count+=i-1 if self[x+i*dx,y+i*dy]=='P'
      }
      return count
    end
  end
end
