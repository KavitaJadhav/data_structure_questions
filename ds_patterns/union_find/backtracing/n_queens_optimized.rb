# Array for fast lookups

def solve_n_queens(num)
  result = []
  board = Array.new(num) { '.' * num }

  visited_columns = Array.new(num, false)
  positive_diagonal = Array.new(2 * num, false)
  negative_diagonal = Array.new(2 * num, false)

  backtrack = ->(row) do
    if row == num
      result << board.map(&:dup)
      return
    end

    (0...num).each do |column|
      pos = row - column + num
      neg = row + column

      next if visited_columns[column] ||
          positive_diagonal[pos] ||
          negative_diagonal[neg]

      board[row][column] = 'Q'
      visited_columns[column] = true
      positive_diagonal[pos] = true
      negative_diagonal[neg] = true

      backtrack.call(row + 1)

      board[row][column] = '.'
      visited_columns[column] = false
      positive_diagonal[pos] = false
      negative_diagonal[neg] = false
    end
  end

  backtrack.call(0)
  result
end