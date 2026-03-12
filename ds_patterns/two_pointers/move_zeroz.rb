# https://leetcode.com/problems/move-zeroes/
#     https://www.youtube.com/watch?v=aayNRwUN3Do
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.

# Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
#
# Note that you must do this in-place without making a copy of the array.
#
#
#
# Example 1:
#
# Input: nums = [0,1,0,3,12]
# Output: [1,3,12,0,0]
# Example 2:
#
# Input: nums = [0]
# Output: [0]
#
#


def move_zeroes(nums)
  index_of_first_zero = 0
  nums.each_with_index do |number, iterator_index|
    if number != 0
      nums[index_of_first_zero], nums[iterator_index] = nums[iterator_index],
          nums[index_of_first_zero]
      index_of_first_zero += 1
    end
  end
end

puts move_zeroes([0]) == [0]
puts move_zeroes([0, 1, 0, 3, 12]) == [1, 3, 12, 0, 0]
puts move_zeroes([1,0,1]) == [1,1,0]
puts move_zeroes([1, 2, 0, 4, 0, 5, 0, 6]) == [1, 2, 4, 5, 6, 0, 0, 0]
