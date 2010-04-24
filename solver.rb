
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
    end
    def h
    end
    def [](x,y)
    end
    def possible_pos
      []
    end
  end
end
