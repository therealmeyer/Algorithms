require_relative 'heap'

def five_hundred_files(files)
  # files array of arrays
  prc = Proc.new do |x[0], y[0]|
    x[0] <=> y[0]
  end 
      
  heap = BinaryMinHeap.new(&prc)

  (0...files.length).each do |i|
    heap.push([files[i][0], i, 0])
  end 

  while heap.count > 0
    min = heap.extract
    result << min[0]
    next_arr_i = min[1]
    next_idx = min[2] + 1
    next_el = files[next_arr_i][next_idx]
    heap.push(next_el)
  end 

  result

  # (0...files.length).each do |file_idx|
  #   (0...files[file_idx].length).each |timestamp_idx|
  #     heap.push(files[file_idx][timestamp_idx])
  #   end 

  # end 
  
end 