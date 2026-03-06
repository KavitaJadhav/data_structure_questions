# https://leetcode.com/problems/longest-increasing-subsequence/
#     https://www.youtube.com/watch?v=cjWnW0hdF1Y&t=354s
# @param {Integer[]} nums
# @return {Integer}

# Approach - start from last element.. find longest subsequence from current index to last element. store in map
# Complexity
# Time: O(N²)
#
# Space: O(N)
#
# Todo: explore ONlogN solution
#
def length_of_lis(numbers)
  return 0 if numbers.empty?
  subsequence = Array.new(numbers.size, 1)

  for i_index in (numbers.size - 1).downto(0)
    for j_index in (i_index + 1)..numbers.size - 1
      if numbers[i_index] < numbers[j_index]
        subsequence[i_index] = [subsequence[i_index] , 1 + subsequence[j_index] ].max
      end
    end
  end

  subsequence.max
end

# ONlogN solution
# def length_of_lis(nums)
#   return 0 if nums.empty?
#
#   tails = []
#
#   nums.each do |num|
#     left = 0
#     right = tails.length
#
#     # binary search
#     while left < right
#       mid = (left + right) / 2
#       if tails[mid] < num
#         left = mid + 1
#       else
#         right = mid
#       end
#     end
#
#     # replace or append
#     if left < tails.length
#       tails[left] = num
#     else
#       tails << num
#     end
#   end
#
#   tails.length
# end