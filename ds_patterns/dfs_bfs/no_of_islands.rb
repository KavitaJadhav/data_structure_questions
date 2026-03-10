# @param {Character[][]} grid
# @return {Integer}

def dfs(grid, i_index, j_index)
  rows = grid.size
  columns = grid.first.size

  return if i_index < 0 || i_index >= rows
  return if j_index < 0 || j_index >= columns

  return  if grid[i_index][j_index] != '1'

  grid[i_index][j_index] = 0
  dfs(grid, i_index - 1, j_index)
  dfs(grid, i_index + 1, j_index)
  dfs(grid, i_index , j_index - 1)
  dfs(grid, i_index , j_index + 1)


end

def num_islands(grid)
  return 0 if grid.nil? || grid.empty?

  islands = 0
  rows = grid.size
  columns = grid.first.size
  for i_index in 0..rows-1
    for j_index in 0..columns-1
      if grid[i_index][j_index] == '1'
        dfs(grid, i_index, j_index)
        islands += 1

      end
    end
  end

  return islands
end