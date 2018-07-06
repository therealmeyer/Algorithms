require_relative 'heap'

def almost_sorted(stream, k)
  prc = Proc.new do |x[0], y[0]|
    x[0] <=> y[0]
  end 
  heap = BinaryMinHeap.new(&prc)
  k.times do 
    heap.push(stream.shift)
  end 
  until stream.empty?
    puts heap.extract
    heap.push(stream.shift)
  end 
end 