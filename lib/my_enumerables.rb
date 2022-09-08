# frozen_string_literal: true

# just a top level documentation because rubocop annoys me
module Enumerable
  # Your code goes here
  def my_all?
    original_obj = self.clone
    control = 0

    (0...original_obj.length).each {|i| control += 1 if yield(original_obj[i])} if block_given?
    control == original_obj.length
  end

  def my_any?
    original_obj = self.clone

    (0...original_obj.length).each {|i| return true if yield(original_obj[i]) } if block_given?
    false
  end

  def my_count
    original_obj = self.clone
    return original_obj.length unless block_given?
    control = 0
    (0...original_obj.length).each {|i| control +=1 if yield(original_obj[i])}
    control
  end
  def my_each_with_index
    original_obj = self.clone
    result = original_obj.class.new

    if block_given?
      (0...original_obj.length).each do |i|
        result = yield(original_obj[i], i)
      end
    end
    result.nil? ? original_obj : result
  end

  def my_inject(initial = nil)
    original_obj = self.clone
    memo = initial.nil? ? 0 : initial
    if block_given?
      (0...original_obj.length).each do | i |
        memo = yield(memo, original_obj[i])
      end
    end
    memo
  end

  def my_map
    return Enumerator.new unless block_given?
    original_obj = self.clone
    result_arr = []
    (0...original_obj.length).each { |i| result_arr.push(yield(original_obj[i]))}
    result_arr
  end

  def my_none?
    original_obj = self.clone
    control = 0

    (0...original_obj.length).each {|i| control += 1 if yield(original_obj[i]) } if block_given?
    control == 0
  end

  def my_select
    return Enumerator.new unless block_given?
    original_obj = self.clone
    result = original_obj.class.new

    (0...original_obj.length).each {|i| result.push(original_obj[i]) if yield(original_obj[i])}
    result.nil? ? original_obj : result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return Enumerator.new unless block_given?
    result_array = Array.new
    original_array = self.clone

    (0...original_array.length).each {| i | result_array.push(yield(original_array[i]))}

    result_array.all?{|x| x.nil?} ? original_array : result_array
  end
end