# https://leetcode.com/problems/binary-search/

require 'byebug'

def binary_search(numbers, target, start_index, end_index)
  return -1 if start_index > end_index

  mid_index = (start_index + end_index) / 2

  return mid_index if target == numbers[mid_index]

  if target < numbers[mid_index]
    return binary_search(numbers, target, start_index, mid_index - 1)
  else
    return binary_search(numbers, target, mid_index + 1, end_index)
  end

  -1
end

def search(numbers, target)
  binary_search(numbers, target, 0, numbers.length - 1)
end

puts search([], 15) == -1
puts search([-1, 0, 3, 5, 9, 12], 15) == -1
puts search([-1, 0, 3, 5, 9, 12], 9) == 4
puts search([-1, 0, 3, 5, 9, 12], 0) == 1
