# https://neetcode.io/problems/max-water-container/question
# https://leetcode.com/problems/container-with-most-water/description/
# You are given an integer array heights where heights[i] represents the height of the
# i
# t
# h
# i
# th
# bar.
#
# You may choose any two bars to form a container. Return the maximum amount of water a container can store.
#

# Approach - move 2 paointers from both ends of array and find max area between array elements
# move pointer from min element and stop when both pointers cross each other

# set default pointers
# calculate area
# move smaller element pointer
# return area
# Complexity
# Space: O(N)
# Time: O(N)
require 'byebug'

def water_area(heights)
  return 0 if heights.empty?

  largest_area = 0
  left_index = 0
  right_index = heights.size - 1

  while left_index < right_index do
    width = right_index - left_index
    if heights[left_index] < heights[right_index]
      height = heights[left_index]
      left_index = left_index + 1
    else
      height = heights[right_index]
      right_index = right_index -1
    end

    area = width * height
    largest_area = area if area > largest_area
  end

  largest_area
end

puts water_area([]) == 0
puts water_area([5, 6]) == 5
puts water_area([1, 8, 6, 2, 5, 4, 8, 3, 7]) == 49
puts water_area([1, 7, 3, 5, 9, 4]) == 21
puts water_area([5, 2, 6, 7, 4, 1]) == 16