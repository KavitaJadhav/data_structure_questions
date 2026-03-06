# https://www.youtube.com/watch?v=XYQecbcd6_c
# https://leetcode.com/problems/longest-palindromic-substring/description/
#     https://www.youtube.com/watch?v=y2BD4MJqV20
#
# Given a string s, return the longest palindromic substring in s.

# Example 1:
# Input: s = "babad"
# Output: "bab"
# Explanation: "aba" is also a valid answer.

# Example 2:
# Input: s = "cbbd"
# Output: "bb"
#Complexity
# Space: O(1) -  variables
# Time - O(n²), O(n Square) - n iterations * n palindrome checks with indexes

require 'byebug'

def palindrom_length(string, start_index, end_index)
  result = ''

  while (start_index > -1 && end_index < string.length && string[start_index] == string[end_index])
    result = string[start_index..end_index]
    start_index -= 1
    end_index += 1
  end

  result
end

def longest_palindrome(string)
  return string if string.length < 2

  biggest_palindrome = ''
  for index in 0..string.length - 1
    odd_palindrome = palindrom_length(string, index, index)
    even_palindrome = palindrom_length(string, index, index + 1)

    if odd_palindrome.length > biggest_palindrome.length
      biggest_palindrome = odd_palindrome
    end

    if even_palindrome.length > biggest_palindrome.length
      biggest_palindrome = even_palindrome
    end

  end
  biggest_palindrome
end


# def palindrom_length(string, left, right)
#   while left >= 0 && right < string.length && string[left] == string[right]
#     left -= 1
#     right += 1
#   end
#   # Return length of palindrome
#   right - left - 1
# end
#
# def longest_palindrome(string)
#   return string if string.length < 2
#
#   biggest_palindrome_start = 0
#   biggest_palindrome_len = 0
#
#   (0...string.length).each do |index|
#     # Odd length palindrome
#     odd_len = palindrom_length(string, index, index)
#     # Even length palindrome
#     even_len = palindrom_length(string, index, index + 1)
#
#     len = [odd_len, even_len].max
#
#     if len > biggest_palindrome_len
#       biggest_palindrome_len = len
#       biggest_palindrome_start = index - (len - 1) / 2
#     end
#   end
#
#   # Slice once at the end
#   string[biggest_palindrome_start, biggest_palindrome_len]
# end

puts longest_palindrome('') == ''
puts longest_palindrome('a') == 'a'
puts longest_palindrome('abbd') == 'bb'
puts longest_palindrome('abcccccbacsdfg') == 'abcccccba'
puts longest_palindrome('abcdkkkkkkkkkkkkkkkkk') == 'kkkkkkkkkkkkkkkkk'