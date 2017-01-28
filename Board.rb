require_relative "skeleton/lib/00_tree_node"

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(3) {Array.new(3){PolyTreeNode.new(nil)} }
    add_values
  end

  def get_node(pos)
    @grid[pos[0]][pos[1]]
  end

  def add_values
    @grid.each_with_index do |row, i|
      row.each_with_index do |node, j|
        node.value = [i,j]
      end
    end
  end
end


# testnode = PolyTreeNode.new(5)
