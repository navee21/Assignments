require_relative "Board"
require "byebug"
class KnightPathFinder
  POSITIONS = [
    #[row,col]
    [1,2],
    [-1,2],
    [2,1],
    [2,-1],
    [-2, 1],
    [-2, -1],
    [1, -2],
    [-1, -2]

  ]
  attr_accessor :board, :start_pos, :end_pos, :visited_pos

  def initialize(start_pos)
    @board=Board.new
    @start_pos=start_pos
    @end_pos=nil
    @visited_pos = []
  end

#updates nodes and probably what we were suppose to do
  def build_move_tree
    #starts at start_pos
    queue = []
    queue << @start_pos
    path = []
    until queue.empty?
      pos = queue.shift
      @visited_pos << pos
      node = @board.get_node(pos)
      if node.value == @end_pos
        return get_path(node)
      else

        new_moves = new_move_positions(pos)
        queue += new_moves.select{|x| !@visited_pos.include?(x)}

        assign_pointers(new_moves, node)

      end

    end
  end
  #        #add children/pos
          #assign current node as parent to those children
  def assign_pointers(child_pos, cur_node)
    child_pos.each do |pos|
      child = @board.get_node(pos)
      cur_node.add_child(child)
      child.parent = cur_node
    end
  end

  def get_path(node)
    path = []
    parent = node.parent
    # debugger
    path << node.value
    until parent.value == @start_pos
      path << parent.value
      parent = parent.parent
    end
    p path
  end




#returns an array of possible next moves
  def new_move_positions(pos)
    potential_position = POSITIONS.map{|x| add_pos(pos,x)}
    potential_position = potential_position.select{|x| valid_move?(x)}
  end

  def add_pos(pos1,pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

#only checks if outside board
  def valid_move?(pos)
    row = pos[0]
    col = pos[1]
    max_len = @board.grid.length

    if(row >= 0 && row < max_len) && (col >= 0 && col < max_len)
      return true
    end
    false
  end



end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new([0,0])
  k.end_pos = [0,1]
  k.build_move_tree

end
