# https://leetcode.com/problems/trapping-rain-water/description/
#     https://www.youtube.com/watch?v=ZI2z5pq0TqA
# https://www.youtube.com/watch?v=UHHp8USwx4M&pp=0gcJCZEKAYcqIYzv

# elevation map -topographic map, is a visual representation of the height of a geographic location relative to mean sea level.
#
# Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.
#

# Approach - two pointers moving for each directions indicating right and left height
# find the difference between abs(right-left)-index height
# move pointer with minimum height
# Update max height if new max height
#Complexity
# Time: O(N)
# Space: O(1)

require 'byebug'

def water_trapping_units(heights)
  total_units = 0
  left_index = 0
  right_index = heights.size - 1

  max_left_height = heights[left_index]
  max_right_height = heights[right_index]

  until left_index == right_index
    if max_left_height < max_right_height
      left_index = left_index + 1
      if heights[left_index] > max_left_height
        max_left_height = heights[left_index]
      else
        total_units += max_left_height - heights[left_index]
      end
    else
      right_index = right_index - 1
      if heights[right_index] > max_right_height
        max_right_height = heights[right_index]
      else
        total_units += max_right_height - heights[right_index]
      end
    end
  end
  total_units
end

puts water_trapping_units([4, 2, 0, 3, 2, 5]) == 9
puts water_trapping_units([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]) == 6