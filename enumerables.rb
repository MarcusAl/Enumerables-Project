module Enumerable
  def my_each(block = nil)
    return to_enum(:self) unless block_given?

    i = 0
    while i < size
     !block.nil? ? block.call(self[i]) : yield(self[i])
     i += 1
    end
    self
  end

  def my_each_with_index(block = nil)
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      !block.nil? ? block.call(self[i], i) : yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select(block = nil)
    return to_enum(:my_each) unless block_given?

    i = 0
    self.times(self.length) do
      if !block.nil?
        puts self[i] if block.call(self[i])
      elsif yield(self[i])
        puts self[i]
      end
      i += 1
    end
  end

  def my_all?(found = nil)
    return to_enum(:my_all?) unless block_given?

    my_each do |i|
      return false if yield(i) == false or found.call(self[i])
    end
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    my_each do |i|
      return true if yield(i) == true
    end
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_any? do |i|
      return false if yield(i) == true
    end
    true
  end

  def my_count
    return size unless block_given?

    counter = 0
    my_each do |i|
      counter += 1 if yield(i) == true
    end
    counter
  end

  def my_map(&myproc)
    return self unless block_given?

    arr = []
    my_each do |i|
      arr << myproc.call(i)
    end
    arr
  end

  def my_inject(initial = 1, sym = nil)
    if sym
      my_each { |e| initial = initial.method(sym).call(e) }
    else
      my_each { |e| initial = yield(initial, e) }
    end
    initial
  end
end

def multiply_els(arr)
  arr.my_inject { |v, i| v * i }
end

array = [6, 19, 19, 25, 7, 30, 20, 27, 22, 19, 18, 29, 12, 31, 2, 12, 0, 32, 1, 20]
block = proc { |num| num.even? }
rang = Range.new(5, 50)

puts rang.my_select(&block) == rang.select(&block)
