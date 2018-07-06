class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc 
  end

  def count
    @store.length 
  end

  def extract
    #swap the first and last value
    @store[0], @store[-1] = @store[-1], @store[0]
    #pop off last value
    val = @store.pop
    #heapify down to reorganize tree
    self.class.heapify_down(@store, 0, count, &@prc)
    #return val
    val
  end

  def peek
    @store.first 
  end

  def push(val)
    #push val onto end
    @store.push(val)
    #heapify up to fix tree
    self.class.heapify_up(@store, count - 1, @prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_1 = 2 * parent_index + 1
    child_2 = 2 * parent_index + 2
    # check if child_1 and/or child_2 are out of bounds
    return child_1 > len - 1 ? nil 
      : child_2 > len - 1 ? [child_1] 
      : [child_1, child_2]
  end

  def self.parent_index(child_index)
    parent = (child_index - 1) / 2
    # raise error if parent out of bounds, i.e. no parent
    raise "root has no parent" if parent < 0
    parent
  end

  # def self.heapify_down(array, parent_idx, len = array.length, &prc)
  #   prc ||= Proc.new { |a, b| a <=> b }
  #   did_swap = true
  #   while did_swap
  #     did_swap = false
  #     child_idxs = self.child_indices(len, parent_idx)
  #     if child_idxs
  #       # if there's more than 1 child and the second child is bigger than the first
  #       if child_idxs.length > 1 && prc.call(array[child_idxs[0]], array[child_idxs[1]]) > 0
  #         swap_idx = child_idxs[1]
  #       else
  #         swap_idx = child_idxs[0]
  #       end
  #     end

  #     if swap_idx && prc.call(array[parent_idx], array[swap_idx]) > 0
  #       array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]
  #       did_swap = true
  #     end

  #     # reset parent_idx instead of recursively passing in swap_idx as the new parent_idx
  #     parent_idx = swap_idx 
  #   end

  #   array
  # end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    parent_el = array[parent_idx]
    left_idx, right_idx = self.child_indices(len, parent_idx)
    children = [] 
    children << array[left_idx] if left_idx 
    children << array[right_idx] if right_idx

    return array if children.empty? || children.all? { |child| prc.call(parent_el, child) <= 0 }
    swap_idx = nil 
    if children.length == 1 
      swap_idx = left_idx
    else 
      swap_idx = prc.call(children[0], children[1]) <= 0 ? left_idx : right_idx
    end 
    array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]

    self.heapify_down(array, swap_idx, len, &prc)
  end 



  def self.heapify_up(array, child_idx, len = array.length, &prc)
     # define default proc
    prc ||= Proc.new { |a, b| a <=> b }
    # return if child is parent
    return array if child_idx == 0 
    # find parent to compare child with
    parent_idx = self.parent_index(child_idx)
    # swap if parent is larger than child
    if prc.call(array[parent_idx], array[child_idx]) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    else
      return
    end
    # recursively call until parent is 0 (or parent is smaller than child)
    # pass in parent_idx as the new idx, since you swapped the value with the value in child_idx
    self.heapify_up(array, parent_idx, len, &prc) if parent_idx != 0
    # return heapified array
    array
  end
end
