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


  def find_words(words)
    words.each do |word|
      insert(word)
    end

    result = []
    rows = @board.size
    columns = @board.first.size

    dfs = lambda do |node, i_index, j_index, word|
      return if i_index < 0 || i_index >= rows || j_index < 0 || j_index >= columns

      character = @board[i_index][j_index]
      return if character == '#'

      child_node = node.children[character]
      return if child_node.nil?

      @board[i_index][j_index] = '#'
      word += character

      if child_node.complete
        result << word
        child_node.complete = false

      end

      dfs.call(child_node, i_index + 1, j_index, word)
      dfs.call(child_node, i_index - 1, j_index, word)
      dfs.call(child_node, i_index, j_index + 1, word)
      dfs.call(child_node, i_index, j_index - 1, word)

      @board[i_index][j_index] = character
      if child_node.children.empty? && !child_node.complete
        node.children.delete(character)
      end
    end

    for i_index in 0..rows - 1
      for j_index in 0..columns - 1
         dfs.call(@root, i_index, j_index, '')
      end
    end

    result
  end
end


def find_words(board, words)
  WordSearch.new(board).find_words(words)
end

# puts find_words([["o", "a", "a", "n"], ["e", "t", "a", "e"], ["i", "h", "k", "r"], ["i", "f", "l", "v"]], ["oath", "pea", "eat", "rain"])
puts find_words([["b","a"],["b","b"]], ["aba","a"])
# puts find_words([["o", "a", "t", "h"]], ["oath"])