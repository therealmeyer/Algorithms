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
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    self.class.heapify_down(@store, 0, count, &@prc)
    val
  end

  def peek
    @store.first 
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count - 1, @prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_1 = 2 * parent_index + 1
    child_2 = 2 * parent_index + 2
    return child_1 > len - 1 ? nil 
      : child_2 > len - 1 ? [child_1] 
      : [child_1, child_2]
  end

  def self.parent_index(child_index)
    parent = (child_index - 1) / 2
    raise "root has no parent" if parent < 0
    parent
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    did_swap = true
    while did_swap
      did_swap = false
      child_idxs = self.child_indices(len, parent_idx)
      if child_idxs
        # more than 1 child 
        if child_idxs.length > 1 && prc.call(array[child_idxs[0]], array[child_idxs[1]]) > 0
          swap_idx = child_idxs[1]
        else
          swap_idx = child_idxs[0]
        end
      end

      if swap_idx && prc.call(array[parent_idx], array[swap_idx]) > 0
        array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]
        did_swap = true
      end

      parent_idx = swap_idx 
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)

    prc ||= Proc.new { |a, b| a <=> b }
    return if child_idx == 0 
    
    parent_idx = self.parent_index(child_idx)
    
    if prc.call(array[parent_idx], array[child_idx]) > 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    else
      return
    end
    
    self.heapify_up(array, parent_idx, len, &prc) if parent_idx != 0
    array
  end
end
