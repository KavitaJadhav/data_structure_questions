# Todo: Add notes, whats improved here..
#

require 'byebug'


def dfs(board, word, i_index, j_index, word_index)
  temp_cell_value = '#'
  rows = board.size
  columns = board.first.size

  return false if (i_index >= rows || j_index >= columns || i_index < 0 || j_index < 0)
  return false if board[i_index][j_index] != word[word_index]

  original_cell_value = board[i_index][j_index]
  board[i_index][j_index] = temp_cell_value
  word_index += 1
  return true if word_index == word.size
  found = dfs(board, word, i_index + 1, j_index, word_index) ||
      dfs(board, word, i_index - 1, j_index, word_index) ||
      dfs(board, word, i_index, j_index - 1, word_index) ||
      dfs(board, word, i_index, j_index + 1, word_index)
  board[i_index][j_index] = original_cell_value

  found
end

def exist(board, word)
  rows = board.size
  columns = board.first.size

  board_count = Hash.new(0)
  board.each {|row| row.each {|c| board_count[c] += 1}}
  word.chars.each do |c|
    return false if board_count[c] < word.count(c)
  end

  for i_index in 0..rows - 1
    for j_index in 0..columns - 1
      next unless board[i_index][j_index] == word[0]
      return true if dfs(board, word, i_index, j_index, 0)
    end
  end
  false
end

puts exist([["A", "B", "C", "E"], ["S", "F", "C", "S"], ["A", "D", "E", "E"]], "ABCCED")