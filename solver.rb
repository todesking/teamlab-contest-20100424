require 'pp'
class Solver
  def solve board,reversible
    b=Board.new board,reversible
    if reversible==1 && rand < 0.4
      return [:reverse]
    end
    availables=b.possible_pos.sort_by{|info| -score(b,info)}
    puts 'availables: '
    pp availables
    return [:put,availables.first[:pos]]
  end
  def score(board,info)
    enemy_possible_count=board.put(info[:pos][0],info[:pos][1]).possible_pos.count
    info[:enemys_possible]=enemy_possible_count
    return -enemy_possible_count*100+info[:count]
  end
  def get_info board,pos
    blank=0
    player=0
    enemy=0
    block=0
    return :blank=>blank,:P=>player,:E=>enemy,:X=>block
  end
  class Board
    DIRECTIONS=[
        [-1,0],
        [1,0],
        [0,-1],
        [0,1],
        [1,1],
        [1,-1],
        [-1,1],
        [-1,-1]
    ]
    def initialize board,reversible
      @board=board
      @reversible=reversible
    end
    def to_strarray
      @board
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
          count=reversible_count(x,y)
          possibles.push :pos=>[x,y],:count=>count if count>0
        }
      }
      return possibles
    end
    def reversible_count x,y
      return 0 unless self[x,y] == '0'
      count=0
      DIRECTIONS.each{|dx,dy|
        i=1
        while self[x+i*dx,y+i*dy] == 'E'
          i+=1
        end
        count+=i-1 if self[x+i*dx,y+i*dy]=='P'
      }
      return count
    end
    def clone
      return Board.new @board.map(&:dup),@reversible
    end
    def put(x,y)
      b=clone
      b.set!(x,y,'P')
      DIRECTIONS.each{|dx,dy|
        i=1
        while b[x+dx*i,y+dy*i]=='E'
          i+=1
        end
        if b[x+dx*i,y+dy*i]=='P'
          (1...i).each{|j|
            b.set!(x+dx*j,y+dy*j,'P')
          }
        end
      }
      return b
    end
    def set!(x,y,cell)
      @board[y][x]=cell[0]
    end
    def reverse
      b=clone
      b.reverse!
      return b
    end
    def reverse!
      @board=@board.map{|line| line.tr('PE','EP') }
    end
  end
end
