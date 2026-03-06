# Given an array of strings strs, group the anagrams together. You can return the answer in any order.
#
#
#
#     Example 1:
#
#     Input: strs = ["eat","tea","tan","ate","nat","bat"]
#
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
#
# Explanation:
#
#     There is no string in strs that can be rearranged to form "bat".
#     The strings "nat" and "tan" are anagrams as they can be rearranged to form each other.
#     The strings "ate", "eat", and "tea" are anagrams as they can be rearranged to form each other.
#     Example 2:
#
#     Input: strs = [""]
#
# Output: [[""]]
#
# Example 3:
#
#     Input: strs = ["a"]
#
# Output: [["a"]]
#


# @param {String[]} strs
# @return {String[][]}


# EACH word
# create anagram list
# find all anagrams from main list
# add in result and delete from main list
# return result
# calculate complexity
# space
# time

# check if list is empty
# list size one then no changes needed
# element length one then no looping needed
# if nil elements, filter or add as one group and remove all other nil elements

require 'byebug'

# Naive Idea
# For every string:
#
# Compare it with existing groups
#
# Check if it’s an anagram of the first element of a group
#
# If yes → add to that group
#
# Else → create a new group
#
# Anagram check = sort both strings and compare

# ⏱ Complexity (Why This Is Naive)
#
# Let n = number of strings
#
# Let k = max string length
#
# Time
#
# Outer loop → n
#
# Inner loop → up to n
#
# Sorting each string → k log k
#
# ➡ O(n² · k log k) ❌
#
def group_anagrams_naive(strs)
  result = []

  strs.each do |str|
    placed = false

    result.each do |group|
      # compare with first string in the group
      if str.chars.sort == group[0].chars.sort
        group << str
        placed = true
        break
      end
    end

    # if no matching group found
    result << [str] unless placed
  end

  result
end

# Optimised
# Approach - generate hash with key as group id
# Key is generated with character index in alphabets
# ⏱ Complexity
# Time: O(n * k)
# Space: O(n * k)
#n = number of words
#k = max length of word
def group_anagrams(input)
  return [] if input.empty?
  return [input] if input.size == 1

  anagram_groups = Hash.new {|hash, key| hash[key] = []}
  input.each do |string|
    key = Array.new(26, 0)
    string.each_char do |character|
      index = character.ord - 'a'.ord
      key[index] += 1
    end
    anagram_groups[key] << string
  end
  anagram_groups.values
end


puts group_anagrams([]) == []
puts group_anagrams(["hello"]) == [["hello"]]
puts group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"]) == [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
#