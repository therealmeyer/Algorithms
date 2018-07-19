class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array <= 1
    pivot = array[0]
    left = array[1..-1].select { |el| el < pivot }
    right = array[1..-1].select { |el| el >= pivto }
    self.sort1(left) + [pivot] + self.sort2(right) 
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1 
    # pivot = rand(length) + start
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    
    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    sort2!(array, start, left_length, &prc) 
    sort2!(array, pivot_idx + 1, right_length, &prc)

    array

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }
    partition_idx = start 
    pivot = array[start]
    # pivot_idx = rand(0..length-1)
    # pivot = array[pivot_idx]

    ((partition_idx + 1)..(partition_idx + length - 1)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[partition_idx + 1], array[idx] = array[idx], array[partition_idx + 1]
        partition_idx += 1
      end
    end

    array[start], array[partition_idx] = array[partition_idx], array[start]

    partition_idx
  end


end


