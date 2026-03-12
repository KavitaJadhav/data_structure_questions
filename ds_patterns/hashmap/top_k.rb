# https://leetcode.com/problems/top-k-frequent-elements/
# Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

# Input:  = [1,1,1,2,2,3], k = 2
# Output: [1,2]

def top(k, numbers)
  return [] if k > numbers.count || k < 0
  return [] if numbers.count == 0
  # map
  # array- size n - How many elements found that many times

  count_map = Hash.new{0}

  numbers.each_with_index do |number, index|
    count = count_map[number]
    count_map[number] = count_map[number] + 1
  end

  count_list = Array.new(numbers.size+1){ []}
  count_map.each do |number, count|
    count_list[count].push(number)
  end

  result = []
  numbers.size.downto(0) do |iterator|
    count_list[iterator].each do |number|
      break if result.size == k
      result.push(number)
    end
  end
  result
end

puts top(2, [1,1,1,2,2,3])==[1,2]
puts top(2, [1,1,1,1,1,1])==[1]
