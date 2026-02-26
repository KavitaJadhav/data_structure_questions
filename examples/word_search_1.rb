
# https://leetcode.com/problems/word-search/

# Given an m x n grid of characters board and a string word, return true if word exists in the grid.
    # The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.


# Algorithm: Depth‑First Search (DFS) with Backtracking
# Time Complexity:
#
# O(m×n×3L)
#
# (where L = word length)
#
# Space Complexity:
# O(L)
# (due to recursion)

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
require 'byebug'

require 'set'


def dfs(board, word, i_index, j_index, word_index, visited_cells)
  rows = board.size
  columns = board.first.size

  return false if (i_index >= rows || j_index >= columns || i_index < 0 || j_index < 0)
  # byebug
  return false if (visited_cells.include?([i_index, j_index]))
  return false if board[i_index][j_index] != word[word_index]

  word_index += 1
  visited_cells.add([i_index, j_index])
  return true if word_index == word.size
  return dfs(board, word, i_index + 1, j_index, word_index, visited_cells) ||
      dfs(board, word, i_index - 1, j_index, word_index, visited_cells) ||
      dfs(board, word, i_index, j_index - 1, word_index, visited_cells) ||
      dfs(board, word, i_index, j_index + 1, word_index, visited_cells)

end

def exist(board, word)
  rows = board.size
  columns = board.first.size

  for i_index in 0..rows - 1
    for j_index in 0..columns - 1
      return true if dfs(board, word, i_index, j_index, 0, Set.new)
    end
  end
  false
end

puts exist([["A", "B", "C", "E"], ["S", "F", "C", "S"], ["A", "D", "E", "E"]], "ABCB")