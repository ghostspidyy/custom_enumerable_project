module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    result_array = Array.new
    original_array = self.clone
    if block_given?
      (0...original_array.length).each do| i |
        result_array.push(yield(original_array[i]))
      end
    else
      result_array = Enumerator.new
    end

    result_array.all?{|x| x.nil?} ? original_array : result_array
  end
end