# https://www.youtube.com/watch?v=dXV83KXt7KA&t=325s
# https://www.youtube.com/watch?v=XEmy13g1Qxc
# # https://www.youtube.com/shorts/QhO_259T8XM?feature=share

# Given an integer array nums and an integer k, return the kth largest element in the array.
#
# Note that it is the kth largest element in the sorted order, not the kth distinct element.
#
# Can you solve it without sorting?
#
#
#
# Example 1:
#
# Input: nums = [3,2,1,5,6,4], k = 2
# Output: 5
# Example 2:
#
# Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
# Output: 4

# Solutions
# Sort and return kth element - O(NlogN)
# mean heap with size k- O(klogN)
# QuickSelect O(N)
# Quickselect is like Quick sort.. We focus only on 1 part of pivot

# @wip
# def quick_select(values, k, left_index, right_index)
#   pivot = values[right_index]
#
#   for iterator in (left_index..right_index - 1)
#     if (values[iterator] > pivot)
#
#     end
#   end
# end
#
# def kth_largest(values, k)
#
#   quick_select(values, k, 0, values.size - 1)
# end

require 'byebug'
# Using min heap - heap will only have k largest elements in asc order
# Complexity:
# Space= O(K)
# Time=O(n log k)
def kth_largest(values, k)
  heap = []

  values.each do |value|
    heap.push(value)
    heap.sort!
    heap.shift if heap.size > k
  end

  heap.first
end

puts kth_largest([3, 2, 1, 5, 6, 4], 2) == 5
puts kth_largest([3, 2, 5, 3, 1, 2, 4, 5, 5, 6], 4) == 5