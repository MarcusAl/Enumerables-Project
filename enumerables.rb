module Enumerable
  def my_each
    return to_enum unless block_given?

    to_a.length.times do |index|
      yield to_a[index]
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    to_a.length.times do |index|
      yield(to_a[index], index)
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    results = []
    my_each { |item| results.push(item) if yield item }
    results
  end

  def my_all?(input = nil)
    if block_given?
      to_a.my_each { |fdm| return false if yield(fdm) == false }
      return true
    elsif input.nil?
      to_a.my_each { |fdm| return false if fdm.nil? || fdm == false }
    elsif !input.nil? && (input.is_a? Class)
      to_a.my_each { |fdm| return false unless [fdm.class, fdm.class.superclass].include?(input) }
    elsif !input.nil? && input.instance_of?(Regexp)
      to_a.my_each { |fdm| return false unless fdm.match(fdm) }
    else
      to_a.my_each { |fdm| return false if fdm != input }
    end
    true
  end

  def my_any?(input = nil)
    if block_given?
      to_a.my_each { |ele| return true if yield(ele) }
      return false
    elsif input.nil?
      to_a.my_each { |ele| return true if ele }
    elsif !input.nil? && (input.is_a? Class)
      to_a.my_each { |ele| return true if [ele.class, ele.class.superclass].include?(input) }
    elsif !input.nil? && input.instance_of?(Regexp)
      to_a.my_each { |ele| return true if input.match(ele) }
    else
      to_a.my_each { |ele| return true if ele == input }
    end
    false
  end

  def my_none?(input = nil, &block)
    !my_any?(input, &block)
  end

  def my_map(proc = nil)
    return to_enum unless block_given? or !proc.nil?

    arr = []
    if proc.nil?
      to_a.my_each { |ele| arr << yield(ele) }
    else
      to_a.my_each { |ele| arr << proc.call(ele) }
    end
    arr
  end

  def my_inject(start = nil, sym = nil)
    if (!start.nil? && sym.nil?) && (start.is_a?(Symbol) || start.is_a?(String))
      sym = start
      start = nil
    end
    if !block_given? && !sym.nil?
      to_a.my_each { |item| start = start.nil? ? item : start.send(sym, item) }
    else
      to_a.my_each { |item| start = start.nil? ? item : yield(start, item) }
    end
    start
  end
end

def multiply_els(input)
  input.my_inject(:*)
end
