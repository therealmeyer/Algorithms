require_relative 'graph'
require 'set'
# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's Algorithm
# def topological_sort(vertices)
#   sorted = []
#   queue = []
#   vertices.each do |vertex|
#     if vertex.in_edges.length < 1
#       queue.push(vertex)
#     end
#   end
#   until queue.empty?
#     top = queue.shift
#     sorted << top
#     edges_len = top.out_edges.length
#       edges_len.times do
#         edge = top.out_edges.shift
#         if edge.to_vertex.in_edges.empty?
#             queue.push(edge)
#         end
#         edge.destroy!
#       end

#       ## shift on next round of vertices
#       vertices.each do |vertex|
#         if vertex.in_edges.empty?
#           queue.push(vertex) unless queue.include?(vertex) || sorted.include?(vertex)
#         end
#       end
#     end

#     sorted.length == vertices.length ? sorted : []
# end

#Khan's algorithm (using destroy)
# --------------------------------------
def topological_sort(vertices)
  order = []
  queue = []
  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end

  until queue.empty?
    current = queue.shift
    order << current
    current.out_edges.dup.each do |edge|
      to_vert = edge.to_vertex
      queue << to_vert if to_vert.in_edges.count <= 1
      edge.destroy!
    end
  end

  order.length == vertices.length ? order : []
end
# -----------------------------------------


#Khan's algorithm (using in_edge_count)

# def topological_sort(vertices)
#   order = []
#   queue = []
#   in_edge_count = {}
#   vertices.each do |vertex|
#     in_edge_count[vertex] = vertex.in_edges.count
#     queue << vertex if vertex.in_edges.empty?
#   end

#   until queue.empty?
#     current = queue.shift
#     order << current
#     current.out_edges.each do |edge|
#       to_vert = edge.to_vertex
#       in_edge_count[to_vert] -= 1
#       queue << to_vert if in_edge_count[to_vert] == 0
#     end
#   end

#   order.length == vertices.length ? order : []
# end


# Tarjan's Algorithm (without cycle catching)

# def topological_sort(vertices)
#   order = []
#   explored = Set.new

#   vertices.each do |vertex|
#     dfs!(order, explored, vertex) unless explored.include?(vertex)
#   end

#   order

# end

# def dfs(order, explored, vertex)
#   explored.add(vertex)

#   vertex.out_edges.each do |edge|
#     to_vertex = edge.to_vertex
#     dfs!(order, explored, to_vertex) unless explored.include?(vertex)
#   end

#   order.unshift(vertex)
# end

# Tarjan's Algorithm (with cycle catching)

# def topological_sort(vertices)
#   order = []
#   explored = Set.new
#   temp = Set.new
#   cycle = false
#
#   vertices.each do |vertex|
#
#     cycle = dfs!(order, explored, vertex) unless explored.include?(vertex)
#     return [] if cycle
#   end
#
#   order
#
# end

def dfs(order, explored, vertex)
  return true if temp.include?(vertex)
  temp.add(vertex)

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    cycle = dfs!(order, explored, to_vertex) unless explored.include?(vertex)
    return true if cycle
  end

  explored.add(vertex)
  temp.delete(vertex)
  order.unshift(vertex)
end
