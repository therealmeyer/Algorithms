# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative './graph'

def install_order(arr)
  queue = []
  sorted = []
  graph = []
  arr.each do |connection|
    vertex1 = Vertex.new(connection[0]) 
    vertex2 = Vertex.new(connection[1])
    graph << vertex1 unless graph.include?(vertex1)
    graph << vertex2 unless graph.include?(vertex2)
    Edge.new(vertex1, vertex2)
  end 
  graph.each do |vertex| 
    if vertex.in_edges.length < 1
      queue.push(vertex) 
      graph.delete(vertex)
    end 
  end 
  until queue.empty? 
    top = queue.shift 

    top.out_edges.each do |edge| 
      queue.push(edge.to_vertex)
      edge.destroy! 
    end 
    sorted.push(top)
  end 
  if graph.empty? 
    return sorted
  else 
    return [] 
  end 
end
