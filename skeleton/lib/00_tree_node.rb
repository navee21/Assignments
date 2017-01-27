require "byebug"
class PolyTreeNode

attr_accessor :value, :children, :parent

  def initialize(value)
    @value=value
    @children = []
    @parent = nil
  end

  def parent= (node1)
    @parent.children.delete(self) if !parent.nil?

    if node1.nil?
      return @parent = nil
    end

    @parent=node1
    node1.children << self unless node1.children.include?(self)
  end

  def add_child(node1)
    node1.parent = self if node1.parent != self
    @children<<node1 unless @children.include?(node1)
  end

  def remove_child(node1)
    raise "not a child" if !@children.include?(node1)
    node1.parent = nil
  end

  def dfs(value)
    return self if self.value == value
    return nil if self.children.length == 0

    self.children.each do |el|
      node = el.dfs(value)
      return node unless node.nil?
    end
    nil
  end


  def bfs(value)
    arr = []
    arr << self
    until arr.empty?
      node = arr.shift
      if node.value == value
        return node
      else
        arr += node.children
      end
    end
    nil

  end
end
