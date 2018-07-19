class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2} 
    @froggy_cache = {1 => [[1]], 2=> [[1,1],[2]], 3 => [[1,1,1], [1,2], [2,1], [3]]}
    @super_frog_hops = {1 => [[1]]}
    @maze_cache = {}
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    odd_number = 2 * (n-1) - 1 
    @blair_cache[n] = blair_nums(n-1) + blair_nums(n-2) + odd_number
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    cache = {1 => [[1]], 2=> [[1,1],[2]], 3 => [[1,1,1], [1,2], [2,1], [3]]}
    return cache if n < 4
    (4..n).each do |i| 
      frog_hops_1 = cache[i-1].map { |arr| arr + [1] }
      frog_hops_2 = cache[i-2].map { |arr| arr + [2] }
      frog_hops_3 = cache[i-3].map { |arr| arr + [3] }
      cache[i] = frog_hops_1 + frog_hops_2 + frog_hops_3
    end 
    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @froggy_cache[n] if @froggy_cache[n]
    frog_hops_1 = frog_hops_top_down_helper(n-1).map { |arr| arr + [1] }
    frog_hops_2 = frog_hops_top_down_helper(n-2).map { |arr| arr + [2] }
    frog_hops_3 = frog_hops_top_down_helper(n-3).map { |arr| arr + [3] }
    @froggy_cache[n] = frog_hops_1 + frog_hops_2 + frog_hops_3
    @froggy_cache[n]
  end

  def super_frog_hops(n, k)
    # return @super_frog_hops[n] if n < 2
    # (2..n).each do |i|
    #   new_way_set = [] 

    #   (1..k).each do |first_step|
    #     break if i - first_step < 0 
    #     @super_frog_hops[i-first_step].each do |way|
    #       new_way = [first_step]

    #       way.each do |step|
    #         new_way << step 
    #       end 

    #       new_way_set << new_way
    #     end 
    #   end 
    #   @super_frog_hops[i] = new_way_set
    # end 
    # @super_frog_hops[n]
  end

  def knapsack(weights, values, capacity)
    return 0 if weights.length == 0 || capacity == 0 
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    solution_table = [] 
    (0..capacity).each do |i|
      solution_table[i] = [] 

      (0...weights.length).each do |j|
        if i == 0 
          solution_table[i][j] = 0 
        elsif j == 0 
          solution_table[i][j] = weights[j] > i ? 0 : values[j]
        else 
          option1 = solution_table[i][j-1]
          option2 = weights[j] > i ? 0 : solution_table[i - weights[j]][j-1] + values[j]
          optimum = [option1, option2].max 
          solution_table[i][j] = optimum 
        end 
      end 
    end 
    solution_table
  end

  def maze_solver(maze, start_pos, end_pos)
    build_cache(start_pos)
    solve_maze(maza, start_pos, end_pos)
    find_path(end_pos)
  end

  def solve_maze(maze, start_pos, end_pos)


  end 


  def build_cache(start_pos)
    @maze_cache[start_pos] = nil 
  end 

  def find_path(end_pos)
    path = [] 
    current = end_pos 

    until current.nil? 

  end 

  def get_moves(maze, from_pos)
    directions = [[0,1], [1m]]
  end 


end
