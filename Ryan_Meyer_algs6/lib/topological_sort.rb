require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = [] 
  queue = []
  vertices.each do |vertex| 
    if vertex.in_edges.length < 1
      queue.push(vertex) 
    end 
  end 
  until queue.empty? 
    top = queue.shift 
    sorted << top 
    edges_len = top.out_edges.length
      edges_len.times do
        edge = top.out_edges.shift
        if edge.to_vertex.in_edges.empty?
            queue.push(edge)
        end
        edge.destroy!
      end

      ## shift on next round of vertices
      vertices.each do |vertex|
        if vertex.in_edges.empty?
          queue.push(vertex) unless queue.include?(vertex) || sorted.include?(vertex)
        end
      end
    end

    sorted.length == vertices.length ? sorted : []
end
