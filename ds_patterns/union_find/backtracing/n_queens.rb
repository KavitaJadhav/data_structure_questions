# @param {Integer} n
# @return {String[][]}
require 'set'
def solve_n_queens(num)
  # create board
  result = []
  board = Array.new(num) { '.' * num }
  visited_columns = Set.new
  positive_diagonal = Set.new
  negative_diagonal = Set.new

# backtrack
  backtrace = ->(row) do
    if row==num
      result.push( board.map(&:dup) )
      return
    end

    for column in 0..num-1
      next if visited_columns.include?(column) || positive_diagonal.include?(row - column) || negative_diagonal.include?(column+row)


      board[row][column] = 'Q'
      visited_columns.add(column)
      positive_diagonal.add(row - column)
      negative_diagonal.add(column+row)

      backtrace.call(row+1)

      board[row][column] = '.'
      visited_columns.delete(column)
      positive_diagonal.delete(row - column)
      negative_diagonal.delete(column+row)

    end

  end
# base condition - backtrack complete if rows finished, r=n

# maintain visited columns, positive_diaginals, negative_diagional
# return if row is visited
# add in visisted
# mark unvisited
# backtrack next row
# check column present in

# start backtracking from row 0
  backtrace.call(0)
  return result
end


puts solve_n_queens(4)==[[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
puts solve_n_queens(1)==[["Q"]]



# Template
def backtrack(state)
  if solution_found?
    add_to_result
    return
  end

  choices.each do |choice|
    next if invalid(choice)

    make_choice
    backtrack(new_state)
    undo_choice
  end
end