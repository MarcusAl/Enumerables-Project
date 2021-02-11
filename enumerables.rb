# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:self) unless block_given?

    i = 0
    while i < size
      yield (self[i])
      i += 1
    end
    self
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

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    my_each do |i|
      new_arr << i if yield(i)
    end
    new_arr
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    my_each do |i|
      return false if yield(i) == false
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
puts multiply_els([2,4,5])
