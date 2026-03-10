# https://leetcode.com/problems/word-search-ii/description/
# Given an m x n board of characters and a list of strings words, return all words on the board.
#
# Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.
#

# @param {Character[][]} board
# @param {String[]} words
# @return {String[]}

require 'byebug'
class WordSearch
  class TrieNode
    attr_accessor :children, :complete

    def initialize(value: nil)
      @value = value
      @children = Hash.new
      @complete = false
    end

    def complete!
      @complete = true
    end
  end

#   private_constant TrieNode

  def initialize(board)
    @root = TrieNode.new
    @board = board
  end


  def insert(word)
    current = @root

    word.each_char do |character|
      current.children[character] ||= TrieNode.new(value: character)
      current = current.children[character]
    end

    current.complete!
  end


  def dfs(node, i_index, j_index, word)

    rows = @board.size
    columns = @board.first.size

    return if i_index < 0 || i_index >= rows || j_index < 0 || j_index >= columns
    return if character == '#'
    character = @board[i_index][j_index]
    child_node = node.children[character]
    return if child_node.nil?

    @board[i_index][j_index] = '#'
    word += character

    if child_node.complete
      @board[i_index][j_index] = character
      return word
    end

    result = dfs(child_node, i_index + 1, j_index, word) ||
        dfs(child_node, i_index - 1, j_index, word) ||
        dfs(child_node, i_index, j_index + 1, word) ||
        dfs(child_node, i_index, j_index - 1, word)

    @board[i_index][j_index] = character
    result
  end

  def find_words(words)
    words.each do |word|
      insert(word)
    end

    rows = @board.size
    columns = @board.first.size

    result = []
    for i_index in 0..rows - 1
      for j_index in 0..columns - 1
        word = dfs(@root, i_index, j_index, '')
        result.push(word) unless word.nil?
      end
    end

    result
  end
end


def find_words(board, words)
  WordSearch.new(board).find_words(words)
end

puts find_words([["o", "a", "a", "n"], ["e", "t", "a", "e"], ["i", "h", "k", "r"], ["i", "f", "l", "v"]], ["oath", "pea", "eat", "rain"])
# puts find_words([["o", "a", "t", "h"]], ["oath"])