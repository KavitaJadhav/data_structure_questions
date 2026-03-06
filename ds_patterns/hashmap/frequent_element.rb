# require 'byebug'
# def frequest_element(input)
# #   empty  = -1
# #  all elements are uniq
# # - -1
# #  more then one frequent elements
# # -
#   frequency_map = Hash.new(0)
#
#   input.each do |element|
#     frequency_map[element] += 1
#   end
#   frequency_map.max_by{|key, value| value}.first
# end
#
# puts frequest_element([1, 1, 2, 3, 3, 3, 4]) == 3

# Complexity
#
# Time: O(n)
#
# Space: O(n)

# Approach - scan array to create frequency map + scan to map to find max
# O(n)+O(n) = O(2n) = O(n)
#
def frequent_element(input)
  return -1 if input.nil? || input.empty?

  frequency_map = Hash.new(0)

  input.each do |element|
    frequency_map[element] += 1
  end

  max_frequency = frequency_map.values.max

  # If all elements are unique
  return -1 if max_frequency == 1

  # Find how many elements have max frequency
  max_elements = frequency_map.select { |_, v| v == max_frequency }

  # If more than one element has max frequency
  return -1 if max_elements.length > 1

  max_elements.keys.first
end

puts frequent_element([]) == -1
puts frequent_element([1,2,3]) == -1
puts frequent_element([1,1,2,2]) == -1
puts frequent_element([1,1,2,3,3,3,4]) == 3

