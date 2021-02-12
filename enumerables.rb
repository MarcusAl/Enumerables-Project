module Enumerables

  def my_each(block = nil)
    index = 0
    if block_given?
      size.times do
        if !block.nil?
          block.call(self[index])
        else
          yield(self[index])
        end
        index += 1
      end
    else
      self
    end
  end

  def my_each_with_index(block = nil)
    index = 0
    if block_given?
      size.times do
        if !block.nil?
          block.call(self[index], index)
        else
          yield(self[index], index)
        end
        index += 1
      end
    else
      self
    end
  end

  def my_select(block = nil)
    index = 0
    if block_given?
      size.times do
        if !block.nil?
          puts self[index] if block.call(self[index])
        elsif yield(self[index])
          puts self[index]
        end
        index += 1
      end
    else
      my_each
    end
  end

  def my_all?(match = nil)
    index = 0
    statement = true
    if block_given?
      size.times do
        statement = false unless yield(self[index])
        index += 1
      end
    elsif !match.nil?
      size.times do
        begin
          statement = false if self[index].is_a?(match)
        rescue StandardError
          statement = false if self[index].scan(match)
        end
      end
    end
    statement
  end

  def my_none?(match = nil)
    index = 0
    statement = false
    statement = true if size.zero?
    if block_given?
      size.times do
        statement = true unless yield(self[index])
        index += 1
      end
    elsif !match.nil?
      size.times do
        begin
          statement = true if self[i].is_a?(match)
        rescue StandardError
          statement = true if self[i].scan(match)
        end
        index += 1
      end
    else
      size.times do
        return true if self[index] == true or self[index].nil?

        index += 1
      end
    end
    statement
  end

  def my_any?(match = nil)
    index = 0
    statement = false
    if block_given?
      size.times do
        return true if yield(self[index])

        index += 1
      end
    elsif !match.nil?
      size.times do
        begin
          statement = true if self[index].is_a?(match)
        rescue StandardError
          statement = true if self[index].scan(match)
        end
      end
    else
      size.times do
        return true if self[index] != false or !self[index].nil?
      end
    end
    statement
  end

  def my_count(match = nil)
    index = 0
    if block_given?
      c = 0
      size.times do
        c += 1 if yield(self[index])
        index += 1
      end
      c
    elsif !match.nil?
      c = 0
      size.times do
        c += 1 if self[index] == match
        index += 1
      end
      c
    else
      size.times do
        index += 1
      end
      index
    end
  end

  def my_map(block = nil)
    index = 0
    new_array = []
    my_array = []
    my_array = if respond_to?(:to_ary)
                 self
               else
                 to_a
               end
    if !block.nil?
      my_array.size.times do
        new_array.push(block.call(my_array[index]))
        index += 1
      end
    else
      my_array.size.times do
        new_array.push(yield(my_array[index]))
        index += 1
      end
    end
    new_array
  end

  def my_inject(block = nil)
    my_array = []
    if !block.nil?
      my_array.my_inject { |sum, x| sum + x }
    elsif block_given?
      accumulator = my_array[0]
      my_array.my_each_with_index do |n, index|
        accumulator = yield(accumulator, n) if index != 0
      end
      accumulator
    end
  end
end

def multiply_els(array)
  array.my_inject { |sum, n| sum * n }
end
