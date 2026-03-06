# Given a list of strings, group the strings that are equivalent when rotated. For example, the input
# ["abc", "bca", "cab", "xyz", "yzx", "cba", "aaaa"]
# should return the groups:
#                       {["abc", "bca", "cab"], ["xyz, "yzx"], ["cba"], ["aaaa"]}
#
# The order of the strings or the groups for the result does not matter.
# {["cba"], ["xyz, "yzx"], ["bca", "abc", "cab"], ["aaaa"]}
# is an acceptable solution too.
#
# Knew how to find if one string is a rotated version of the other but couldn't piece out how to put in the common group. Another approach which I preferred is to generate hash of string and seems that is a wrong approach. Any inputs on how to approach for this problem?
#

# https://leetcode.com/discuss/post/865428/apple-phone-interview-group-rotated-stri-zv6n/
# https://leetcode.com/problems/group-rotations/description/
#

# EACH word
# create rotation list
# find all rotations from main list
# add in result and delete from main list
# return result
# calculate complexity
# space
# time

# check if list is empty
# list size one then no changes needed
# element length one then no looping needed
# if nil elements, filter or add as one group and remove all other nil elements
#

# @param {String[]} strs
# @return {String[][]}
#
require 'byebug'

def rotations(string)

  rotations = []
  string_double = string + string
  for index in 0..string.length - 1 do
    rotations << string_double[index..index + string.length - 1]
  end
  rotations
end

def group_rotations(input)

  return [] if input.empty?

  result_groups = []
  until (input.empty?)
    # byebug
    string = input.first
    rotation_group = []

    if string.nil?
      # handle nil -> create a group of all nil values..
    end

    if string.length <= 1
      input.delete(string)
      rotation_group << [string]
    else
      rotations = rotations(string)
      rotations.each do |rotation|
        if input.delete(rotation)
          rotation_group << rotation
        end
      end
    end

    result_groups << rotation_group
  end
  result_groups

end

# Improvements
# Change input array to set
# instead of finding rotations and looping, remove rotation from main array along with loop
#
# Issues in  Code
#
# Method name conflict
#
# def rotations(string)
#   rotations = []
#
#   Using same variable name as method is risky. Better: rot_list.
#
#       string_double[index..index + string.length - 1]
#
#   Off-by-one bug: index + string.length - 1 is correct, yes, but slicing works differently in Ruby:
#
#       str[start..end] is inclusive of both indexes
#
# Your current code works, but more idiomatic: str[index, string.length]
#
# input.delete(anagram)
#
# Inefficient: deletes in O(n)
#
# If input is large → slow
#
# nil handling
#
# Currently ignored. Should handle nil or empty strings.
#
#     Single-character strings
#
# Correctly handled, but can unify logic with rotations (rotations of length 1 is just itself)
#
# Time Complexity
#
# Your current solution:
#
#                  For each string → generate all rotations → for each rotation → search input array → O(n² * k), where n = #strings, k = string length
#
#                                                                                                                           Could be optimized.
puts group_rotations(["eat", "tea", "tan", "ate", "nat", "bat"]) == [["eat", "ate", "tea"], ["tan"], ["nat"], ["bat"]]
puts group_rotations(["eat", "tea", "tan", "ate", "nat", "bat"]) == [["eat", "ate", "tea"], ["tan"], ["nat"], ["bat"]]
#