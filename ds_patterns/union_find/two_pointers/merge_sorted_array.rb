# https://www.youtube.com/watch?v=P1Ic85RarKY
# https://leetcode.com/problems/merge-sorted-array/
# @param {Integer[]} nums1
# @param {Integer} m
# @param {Integer[]} nums2
# @param {Integer} n
# @return {Void} Do not return anything, modify nums1 in-place instead.
require 'byebug'

# Approach - Start from the end of the first array with black spaces(0).. insert element in order
# Complexity
# Space: 0
# Time: O(N) + O (M)
def merge(first_array, first_array_size, second_array, second_array_size)
  first_iterator = first_array_size - 1
  second_iterator = second_array_size - 1

  reverse_index = first_array_size + second_array_size - 1

  while second_iterator >= 0 do
    if first_iterator >= 0 && first_array[first_iterator] > second_array[second_iterator]
      first_array[reverse_index] = first_array[first_iterator]
      first_iterator -= 1
    else
      first_array[reverse_index] = second_array[second_iterator]
      second_iterator -= 1
    end
    reverse_index -= 1

  end
end

merge([4, 5, 0, 0], 2, [1, 2], 2)