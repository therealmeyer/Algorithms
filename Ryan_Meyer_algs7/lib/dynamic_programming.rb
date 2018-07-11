class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2} 
  end

  def blair_nums(n)
    #top-down
    # return @blair_cache[n] if @blair_cache[n]
    # first = @blair_cache[n-1] || blair_nums(n-1)
    # second = @blair_cache[n-2] || blair_nums(n-2)
    # @blair_cache[n-1] = first 
    # @blair_cache[n-2] = second
    # first + second + ((n*2)-3)
    # bottom-up 
    generate_blair_cache(n)
    @blair_cache[n]
  end

  def generate_blair_cache(n)
    (3..n).each do |i|
      @blair_cache[i] = @blair_cache[i-1] + @blair_cache[i-2] + ((i*2)-3)
    end 
  end 

  def frog_hops_bottom_up(n)

  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
