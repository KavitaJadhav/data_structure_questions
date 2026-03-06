# https://leetcode.com/problems/maximum-subarray/submissions/1915191020/
# https://www.youtube.com/watch?v=bJbfO4boNk4

# Given an integer array nums, find the subarray with the largest sum, and return its sum.
#
# Example 1:
# Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
# Output: 6
# Explanation: The subarray [4,-1,2,1] has the largest sum 6.
# Example 2:
#
# Input: nums = [1]
# Output: 1
# Explanation: The subarray [1] has the largest sum 1.
# Example 3:
#
# Input: nums = [5,4,-1,7,8]
# Output: 23
# Explanation: The subarray [5,4,-1,7,8] has the largest sum 23.

#
# @param {Integer[]} nums
# @return {Integer}

require 'byebug'

def max_sub_array(numbers)
  # [-2,1,-3,4,-1,2,1,-5,4]
  maximum_sum = current_sum = numbers.first

  for index in 1..numbers.size - 1
    current_sum = [current_sum + numbers[index], numbers[index]].max
    maximum_sum = [current_sum, maximum_sum].max
  end

  maximum_sum
end

puts max_sub_array([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
puts max_sub_array([1]) == 1
puts max_sub_array([1, -1]) == 1
puts max_sub_array([5, 4, -1, 7, 8]) == 23
puts max_sub_array([-8, -7, -6, -5, -4]) == -4


#Todo: Understand and write approach again
#