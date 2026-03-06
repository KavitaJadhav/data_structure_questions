# https://leetcode.com/problems/house-robber/description/
#     https://www.youtube.com/watch?v=VXqUQYGMnQg

# You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.
# Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.
#
#
# Example 1:
# Input: nums = [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
# Total amount you can rob = 1 + 3 = 4.

# Example 2:
# Input: nums = [2,7,9,3,1]
# Output: 12
# Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
# Total amount you can rob = 2 + 9 + 1 = 12.
#
# Approach - find max value from first 2 numbers.. iterate from rest of the array by taking max from (n-2) or n + (n-1)

# max(total_loot[current_index] + total_loot[current_index-2], total_loot[current_index-1])

# Complexity
# Time: O(N) -> one iteration
# Space: O(N) -> total loot store
def maximum_loot(money_in_the_house)
  total_homes = money_in_the_house.size
  return money_in_the_house.first if total_homes == 1

  total_loot = Array.new(total_homes - 1)

  total_loot[0] = money_in_the_house[0]
  total_loot[1] = money_in_the_house[1]

  for iterator in 2..total_homes - 1
    total_loot[iterator] = [money_in_the_house[iterator] + total_loot[iterator - 2], total_loot[iterator - 1]].max
  end

  total_loot[total_homes - 1]
end
# Todo: Improve to use 2 variables instaed of storing loot in the array. It will reduce space complexity to 0(1)/Constant

# Array - [2, 7, 3, 1, 4, 2, 1, 8]
# Loot -[2, 7, 7, 8, 11, 11, 12, 19]

puts maximum_loot([2]) == 2
puts maximum_loot([1, 2, 3, 1]) == 4
puts maximum_loot([2, 7, 9, 3, 1]) == 12
puts maximum_loot([2, 7, 3, 1, 4, 2, 1, 8]) == 19