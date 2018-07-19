# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative './topological_sort'
require_relative './graph'

def install_order(arr)
  max = arr[0][0]
    arr.each { |tuple| max = tuple.max > max ? tuple.max : max }

    vertices = (1..max).to_a.map { |val| Vertex.new(val) }

    arr.each do |tuple|
      from_idx = vertices.index { |v| v.value == tuple[1] }
      to_idx = vertices.index { |v| v.value == tuple[0] }
      from, to = vertices[from_idx], vertices[to_idx]
      Edge.new(from, to)
    end

    sorted = topological_sort(vertices).map

    sorted.map { |v| v.value }
end


def install_order2(arr) 
  vertices = {}

  arr.each do |tuple|
    vertices[tuple[0]] = Vertex.new(vertices[tuple[0]]) unless vertices[tuple[0]] # && tuple not nill
    vertices[tuple[1]] = Vertex.new(vertices[tuple[1]]) unless vertices[tuple[1]]
    Edge.new(vertices[tuple[1]], vertices[tuple[0]]) # tuple not nil 

  end 

  topological_sort(vertices.values).map { |v| v.value}

end 


def install_order(arr)
  max = 0 
  independent = [] 
  vertices = {}

  arr.each do |tuple|
    vertices[tuple[0]] = Vertex.new(vertices[tuple[0]]) unless vertices[tuple[0]]
    vertices[tuple[1]] = Vertex.new(vertices[tuple[1]]) unless vertices[tuple[1]]
    Edge.new(vertices[tuple[1]], vertices[tuple[0]])

    max = tuple.max if tuple.max > max
  end 

  (1..max).each do |i|
    independent << i unless vertices[i]
  end 

  independent + topological_sort(vertices.values).map { |v| v.value}

end 