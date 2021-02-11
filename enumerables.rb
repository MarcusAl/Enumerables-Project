# frozen_string_literal: true

module Enumerable
  # My.each method 1
  def my_each
    return to_enum(:self) unless block_given?

    i = 0
    while i < size
      yield (self[i])
      i += 1
    end
    self
  end
end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield self[i], i
      i += 1
    end
    self
  end
end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    my_each do |i|
      new_arr << i if yield(i)
    end
    new_arr
  end
end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    my_each do |i|
      return false if yield(i) == false
    end
    true
  end
end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    my_each do |i|
      return true if yield(i) == true
    end
    false
  end
end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_any? do |i|
      return false if yield(i) == true
    end
    true
  end
end

  def my_count
    return self.size unless block_given?

    counter = 0
    self.my_each do |i|
      counter += 1 if yield(i) == true
    end
    counter
  end
end

  def my_map(&myproc)
    return self unless block_given?
        arr = []
        self.my_each do |i|
            arr << myproc.call(i)
        end
        arr
  end
end

def my_inject(i = self[0])
return self unless block_given?

self.my_each do |e|
  i = yield(i, e)
end
i
end

arr = [1, 2, 3, 4, 8, 6, 10]

p arr.my_inject { |i| i * 3}
