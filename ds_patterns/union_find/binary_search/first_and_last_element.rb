# https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/
require 'byebug'
# Given an array of integers nums sorted in non-decreasing order, find the starting and ending position of a given target value.
#
# If target is not found in the array, return [-1, -1].
#
# You must write an algorithm with O(log n) runtime complexity.
#
#
#
# Example 1:
#
# Input: nums = [5,7,7,8,8,10], target = 8
# Output: [3,4]
# Example 2:
#
# Input: nums = [5,7,7,8,8,10], target = 6
# Output: [-1,-1]
# Example 3:
#
# Input: nums = [], target = 0
# Output: [-1,-1]
#

def binary_search(numbers, target, start_index, end_index, left)
  element_index = -1

  while start_index <= end_index do
    mid_index = (start_index + end_index) / 2

    if target < numbers[mid_index]
      end_index = mid_index - 1
    elsif target > numbers[mid_index]
      start_index = mid_index + 1
    else
      element_index = mid_index
      if left
        end_index = mid_index - 1
      else
        start_index = mid_index + 1
      end
    end
  end

  element_index
end

def search(numbers, target)
  [binary_search(numbers, target, 0, numbers.length - 1, true), binary_search(numbers, target, 0, numbers.length - 1, false)]
end

puts search([], 15) == [-1, -1]
puts search([5, 7, 7, 8, 8, 10], 8) == [3, 4]
puts search([5, 7, 7, 8, 8, 10], 6) == [-1, -1]
