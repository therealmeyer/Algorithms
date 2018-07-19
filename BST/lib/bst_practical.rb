require_relative './binary_search_tree'

def kth_largest(tree_node, k)
 
  arr = in_order_traversal(tree_node)
  find(arr[arr.length - k], tree_node)
end


def in_order_traversal(tree_node)
  left = tree_node.left ? in_order_traversal(tree_node.left) : []
  right = tree_node.right ? in_order_traversal(tree_node.right) : []
  left + [tree_node.value] + right
end

def find(value, tree_node) 
  return nil if tree_node == nil 
  return tree_node if tree_node.value == value 
  if value < tree_node.value
    find(value, tree_node.left)
  else 
    find(value, tree_node.right)
  end 
end 


def lower_common_ancestor(root, node1, node2)
  smaller = node1.value > node2.value ? node1.value : node2.value
  if (root.value < node1.value && root.value < node2.value)
    lower_common_ancestor(root.right, node1, node2)
  elsif ()

  return nil unless root.find(node1) || root.find(node2)
  if (!lower_common_ancestor(root.left, node1, node2))
    lower_common_ancestor(root.right, node1, node2)
  else 
    lower_common_ancestor(root.right, node1, node2)
  


end 
