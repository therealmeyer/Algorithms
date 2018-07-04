class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next 
    @next.prev = @prev 
    @next, @prev = nil, nil 
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new 
    @tail = Node.new 
    @head.next = @tail 
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next 
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail 
  end

  def get(key)
    node = get_node(key)
    return nil if node.nil?
    node.val
  end

  def include?(key)
    get_node(key) ? true : false
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next = @tail 
    node.prev = @tail.prev 
    @tail.prev.next = node 
    @tail.prev = node 
  end

  def update(key, val)
    node = get_node(key)
    return nil if node.nil?
    node.val = val
  end

  def remove(key)
    node = get_node(key)
    node.remove
  end

  def each(&prc)
    
    node = @head.next
    until node == @tail
      prc.call(node)
      node = node.next
    end
  
  end

  def get_node(key) 
    node = @head.next 
    until node.key == key
      return nil if node.next == nil 
      node = node.next 
    end 
    node 
  end 

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
