# https://leetcode.com/problems/sliding-window-maximum/description/
# You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.
#
# Return the max sliding window.
#
#
#
# Example 1:
#
# Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
# Output: [3,3,5,5,6,7]
# Explanation:
# Window position                Max
# ---------------               -----
# [1  3  -1] -3  5  3  6  7       3
# 1 [3  -1  -3] 5  3  6  7       3
# 1  3 [-1  -3  5] 3  6  7       5
# 1  3  -1 [-3  5  3] 6  7       5
# 1  3  -1  -3 [5  3  6] 7       6
# 1  3  -1  -3  5 [3  6  7]      7
# Example 2:
#
# Input: nums = [1], k = 1
# Output: [1]

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}

require 'byebug'

def max_sliding_window(nums, k)
  result = []
  queue = [] #Usinng array as a que for now
  left = right = 0
  while right < nums.size
    while !queue.empty? && nums[queue.last] < nums[right]
      queue.pop
    end

    queue.push(right)

    if (right + 1) >= k
      result << nums[queue.first]
      left = left + 1
    end

    while (!queue.empty? && queue.first < left)
      queue.shift
    end

    right += 1
  end
  result
end

puts  max_sliding_window([1, 3, -1, -3, 5, 3, 6, 7], 3)==[3,3,5,5,6,7]
