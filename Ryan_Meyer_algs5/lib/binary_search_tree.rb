# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require_relative './bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil 
  end

  def insert(value)
    if @root == nil 
      @root = BSTNode.new(value) 
    else 
      @root.insert(value)
    end 
  end

  def find(value, tree_node = @root)
    return nil if tree_node == nil 
    return tree_node if tree_node.value == value 
    if value < tree_node.value
      find(value, tree_node.left)
    else 
      find(value, tree_node.right)
    end 
  end

  def delete(value)
    node = find(value, @root)
    return false unless node 
    if node.left == nil && node.right == nil 
      delete_no_children(node)
    elsif node.left == nil || node.right == nil 
      delete_one_child(node)
    else 
      p "Delete both childgren"
      delete_both_children(node)
    end 

  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right == nil 
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || tree_node.right.nil? && tree_node.left.nil?
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)
    if left_depth > right_depth 
      return left_depth+1 
    else 
      return right_depth + 1
    end 
  end 

  def is_balanced?(tree_node = @root)
    left_depth = tree_node.left ? depth(tree_node.left) : 0
    right_depth = tree_node.right ? depth(tree_node.right) : 0
    return false if (left_depth - right_depth).abs > 1 

    left_is_balanced = tree_node.left ? is_balanced?(tree_node.left) : true
    right_is_balanced = tree_node.right ? is_balanced?(tree_node.right) : true

    left_is_balanced && right_is_balanced

  end

  def in_order_traversal(tree_node = @root, arr = [])
    left = tree_node.left ? in_order_traversal(tree_node.left, arr) : []
    right = tree_node.right ? in_order_traversal(tree_node.right, arr) : []
    left + [tree_node.value] + right
  end

  private
  # optional helper methods go here:
  def delete_no_children(node)
    if node == root 
      @root = nil 
    elsif node.parent.right == node 
      node.parent.right = nil 
    else 
      node.parent.left = nil 
    end 
  end 

  def delete_one_child(node)
    node.parent.right == node ? node.parent.right = nil : node.parent.left = nil 
    if node.right 
      if node.parent.value < node.right.value 
        node.parent.right = node.right 
      else 
        node.parent.left = node.right 
      end 
    else 
      if node.parent.value < node.left.value
        node.parent.right = node.left 
      else 
        node.parent.left = node.left  
      end 
    end 
  end 

  def delete_both_children(node)
    max_node = maximum(node.left)
   
    if node.parent.right == node 

      node.parent.right = max_node 
      if max_node.left || max_node.right 
        max_node.parent.right == max_node ? 
          max_node.parent.right = max_node.left || max_node.right :
          max_node.parent.right = max_node.left || max_node.right
      end 
      max_node.parent = node.parent
    else 
      node.parent.left = max_node 
      if max_node.left || max_node.right 
        max_node.parent.right == max_node ? 
          max_node.parent.right = max_node.left || max_node.right :
          max_node.parent.right = max_node.left || max_node.right
      end 
      max_node.parent = node.parent
    end 
      max_node.left = node.left
      max_node.right = node.right
      max_node.left.parent = max_node
      max_node.right.parent = max_node 
  end 

  def swap(node1, node2)
    node1.parent.left == node1 ? node1.parent.left = node2 : node1.parent.right = node2 
      node2.parent = node1.parent
      node1.parent = node2 
      if node1.left == node2
        node2.left = node1
        node2.right = node1.right 
      else 
        node2.right = node1
        node2.left = node1.left
      end 
      node1.left = node2.left 
      node1.right = node2.right 
  end 
end
