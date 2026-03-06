# https://www.youtube.com/watch?v=U8XENwh8Oy8
#
# https://leetcode.com/problems/search-in-rotated-sorted-array/description/
# There is an integer array nums sorted in ascending order (with distinct values).
#
# Prior to being passed to your function, nums is possibly left rotated at an unknown index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be left rotated by 3 indices and become [4,5,6,7,0,1,2].
#
# Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.
#
# You must write an algorithm with O(log n) runtime complexity.
# Example 1:
#
# Input: nums = [4,5,6,7,0,1,2], target = 0
# Output: 4
# Example 2:
#
# Input: nums = [4,5,6,7,0,1,2], target = 3
# Output: -1
# Example 3:
#
# Input: nums = [1], target = 0
# Output: -1

# Metric	Value
# Time	O(log n)
# Space	O(1)

#Approach - two pointers, binary search in array
require 'byebug'

def search(values, target)
  left_index = 0
  right_index = values.size - 1


  while (left_index <= right_index)
    mid_index = (left_index + right_index) / 2

    return mid_index if target == values[mid_index]

    if (values[left_index] < values[mid_index])
      #   left side of the array
      if (target > values[mid_index]) || (target < values[left_index])
        left_index = mid_index + 1
      else
        right_index = mid_index - 1
      end
    else
      #   right side of the array
      if target > values[right_index] || target < values[mid_index]
        right_index = mid_index -1
      else
        left_index = mid_index -1
      end
    end
  end

  -1
end

puts search([4, 5, 6, 7, 0, 1, 2], 0) == 4
puts search([4, 5, 6, 7, 0, 1, 2], 3) == -1
puts search([1], 0) == -1