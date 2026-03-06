# https://leetcode.com/problems/product-of-array-except-self/
# https://www.youtube.com/shorts/HpjJ_527c9U
# @param {Integer[]} nums
# @return {Integer[]}
# Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
#
# The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
#
# You must write an algorithm that runs in O(n) time and without using the division operation.
#
#
#
# Example 1:
# Input: nums = [1,2,3,4]
# Output: [24,12,8,6]

# Example 2:
# Input: nums = [-1,1,0,-3,3]
# Output: [0,0,9,0,0]

require 'byebug'

def product_except_self(numbers)
  prefix_products = Array.new(numbers.size, 1)
  suffix_products = Array.new(numbers.size, 1)
  self_exclusive_products = Array.new(numbers.size, 1)


  for index in 1..numbers.size - 1 do
    prefix_products[index] = prefix_products[index - 1] * numbers[index - 1]
  end

  (numbers.size - 2).downto(0) do |index|
    suffix_products[index] = suffix_products[index + 1] * numbers[index + 1]
  end

  for index in 0..numbers.size - 1 do
    self_exclusive_products[index] = prefix_products[index] * suffix_products[index]
  end
  self_exclusive_products
end

#Todo: Implement to reduce space complexity
# 2nd loop can calculate final results instead of one extra loop
# def product_except_self_optimized(numbers)
#   prefix_products = Array.new(numbers.size, 1)
#   suffix_products = Array.new(numbers.size, 1)
#   self_exclusive_products = Array.new(numbers.size, 1)
#
#
#   for index in 1..numbers.size - 1 do
#     prefix_products[index] = prefix_products[index -1] * numbers[index -1]
#   end
#
#   (numbers.size - 2).downto(0) do |index|
#     suffix_products[index] = suffix_products[index + 1] * numbers[index + 1]
#   end
#
#   for index in 0..numbers.size - 1 do
#     self_exclusive_products[index] = prefix_products[index] * suffix_products[index]
#   end
#   self_exclusive_products
# end

puts product_except_self([1, 2, 3, 4]) == [24, 12, 8, 6]
puts product_except_self([1, 2, 3, 4]) == [24, 12, 8, 6]
puts product_except_self([0, 2, 0, 4]) == [0, 0, 0, 0]
puts product_except_self([1, 1, 1, 1]) == [1, 1, 1, 1]