# @param {Character[][]} board
# @param {String[]} words
# @return {String[]}

require 'byebug'
# @param {Character[][]} board
# @param {String[]} words
# @return {String[]}

class WordSearch
  class TrieNode
    def initialize(value: nil)
      @value = value
      @children = Hash.new
      @complete = false
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
      character_node = current.childern[character]
      if character_node
        current = character_node
      else
        current.childern[character] = TrieNode.new(value: character)
      end
    end
  end

  def dfs(node, i_index, j_index, word)

    rows = boards.size
    columns = boards.first.size

    return if i_index < 0 || i_index >= rows.size || j_index < 0 || j_index > columns.size

    character = @board[i_index][j_index]
    child_node = node.children[character]
    return if child_node.nil?


    @words[i_index][j_index] = '#'
    word += character

    if child_node.complete

      @words[i_index][j_index] = character
      word

    else
      dfs(child_node, i_index + 1, j_index, word)
      dfs(child_node, i_index - 1, j_index, word)
      dfs(child_node, i_index, j_index + 1, word)
      dfs(child_node, i_index, j_index - 1, word)
      @words[i_index][j_index] = character

    end
  end

  def find_words(words)
    words.each do |word|
      insert.add(word)
    end

    rows = boards.size
    columns = boards.first.size

    result = []
    for i_index in 0..rows.size
      for j_index in 0..columns.size
        word = dfs(board, @root, i_index, j_index, '')
        result.push(word) unless work.nil?
      end
    end

    result
  end
end


def find_words(board, words)
  WordSearch.new(board).find_words(words)
end

find_words([["o", "a", "a", "n"], ["e", "t", "a", "e"], ["i", "h", "k", "r"], ["i", "f", "l", "v"]], ["oath", "pea", "eat", "rain"])