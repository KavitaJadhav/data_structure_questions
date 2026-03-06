# http://youtube.com/watch?v=AME6baBpswY
# https://www.youtube.com/watch?v=ZgCZfXPo3hI
# https://www.youtube.com/watch?v=pV2kpPD66nE
# https://leetcode.com/problems/number-of-islands/description/
# Topics
# premium lock icon
# Companies
# Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.
#
#     An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
#
#
#
#     Example 1:
#
#     Input: grid = [
#     ["1","1","1","1","0"],
#     ["1","1","0","1","0"],
#     ["1","1","0","0","0"],
#     ["0","0","0","0","0"]
# ]
# Output: 1
# Example 2:
#
#     Input: grid = [
#     ["1","1","0","0","0"],
#     ["1","1","0","0","0"],
#     ["0","0","1","0","0"],
#     ["0","0","0","1","1"]
# ]
# Output: 3

# Approach - consider all groups of 1 as a graph.
# take one index as a staring point if value is 1(land)
# find all neighbors and mark them visited or convert to 0 so those wont be considered again
# increase island count for each group
# Complexity
# Time: O(M*N) - loop for rows and columns
# Space: O(M*N) - inplace changes

require 'byebug'

def rows_count(grid)
  grid.size
end

def columns_count(grid)
  grid.first.size
end

# Todo:
# Implement BFS - with queue

# DFS - traverse neighbours recursively
def explore_island(grid, row_index, column_index)
# Mark cell as visited/0
# visit nearing cells
# Stop traversing neighbour if
# index outside grid
# index value is 0(water)end

#refactor to smaller methods

  return if !(0..rows_count(grid) - 1).include?(row_index) || !(0..columns_count(grid) - 1).include?(column_index) || grid[row_index][column_index] != "1"

  grid[row_index][column_index] = "0"

  explore_island(grid, row_index, column_index - 1)
  explore_island(grid, row_index - 1, column_index)
  explore_island(grid, row_index + 1, column_index)
  explore_island(grid, row_index, column_index + 1)
end

def find_islands(grid)
  islands_found = 0

  for row_index in 0..rows_count(grid) - 1 do
    for column_index in 0..columns_count(grid) - 1 do
      if grid[row_index][column_index] == "1"
        # byebug
        explore_island(grid, row_index, column_index)
        islands_found += 1
      end
    end
  end

  islands_found
end

puts find_islands([["1", "1", "1", "1", "0"],
                   ["1", "1", "0", "1", "0"],
                   ["1", "1", "0", "0", "0"],
                   ["0", "0", "0", "0", "0"]]) == 1

puts find_islands([["1", "1", "0", "0", "0"],
                   ["1", "1", "0", "0", "0"],
                   ["0", "0", "1", "0", "0"],
                   ["0", "0", "0", "1", "1"]]) == 3