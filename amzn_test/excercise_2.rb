class Node
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def ==(node)
    node.is_a?(Node) &&
        node.value == @value && node.left == @left && node.right == @right
  end

  def to_s
    "(#{left.to_s},#{value},#{right.to_s})"
  end

end

def bstDistance(values, n, node1, node2)
  root = build_tree(values)
  find_distance(root, node1, node2)
end

def find_distance(tree, node1, node2)
  return nil unless tree
  if node1 > tree.value && node2 > tree.value
    find_distance(tree.left, node1, node2)
  elsif node1 < tree.value && node2 < tree.value
    find_distance(tree.right, node1, node2)
  elsif node1 == tree.value
    find_in_subtree(tree, node2)
  elsif node2 == tree.value
    find_in_subtree(tree, node1)
  else
    depth1 = find_in_subtree(tree, node1)
    depth2 = find_in_subtree(tree, node2)
    if depth1 > 0 && depth2 > 0
      depth1 + depth2
    else
      -1
    end
  end
end

def find_in_subtree(tree, value)
  return -1 unless tree
  current = tree
  depth = 0
  while current
    return depth if value == current.value
    depth += 1
    if value > current.value
      current = current.left
    else
      current = current.right
    end
  end
  return -1
end

def build_tree(values)
  root = Node.new(values[0])
  return root if values.length == 1
  values[1..(values.length-1)].each do |value|
    append_to_tree(root, value)
  end
  root
end

def append_to_tree(root, value)
  if value > root.value
    if root.left.nil?
      root.left = Node.new(value)
    else
      append_to_tree(root.left, value)
    end
  else
    if root.right.nil?
      root.right = Node.new(value)
    else
      append_to_tree(root.right, value)
    end
  end
end
