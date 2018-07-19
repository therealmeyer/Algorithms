class BSTNode
  attr_reader :value
  attr_accessor :left, :right, :parent
  def initialize(value)
    @value = value 
    @left = nil 
    @right = nil 
    @parent = nil 
  end

  def insert(new_val)
    if new_val <= @value
      if @left.nil? 
        @left = BSTNode.new(new_val)
        @left.parent = self
      else 
        @left.insert(new_val)
      end 
    elsif new_val > @value
      if @right.nil? 
        @right = BSTNode.new(new_val) 
        @right.parent = self 
      else 
        @right.insert(new_val)
      end 
    end
  end

end


# class BSTNode 
#   attr_reader :value
#   attr_accessor :left, :right
#   def initialize(value)
#     @value = value 
#     @left = nil 
#     @right = nil 
#   end
# end 
