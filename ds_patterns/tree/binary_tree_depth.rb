# https://www.youtube.com/watch?v=ScvTcU2Aifs
# https://leetcode.com/problems/maximum-depth-of-binary-tree/submissions/1915205051/
# Definition for a binary tree node.
# Given the root of a binary tree, return its maximum depth.
# A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.


class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# @param {TreeNode} root
# @return {Integer}
def depth(node)
  return 0 if node.nil?
  return 1 if node.left.nil? && node.right.nil?
  [depth(left), depth(right)].max + 1
end

def max_depth(root)
  depth(root)
end

puts max_depth([3, 9, 20, nil, nil, 15, 7]) === 3
puts max_depth([1, nil, 2]) === 3
puts max_depth([3, 9, nil, 15, nil, 7, nil]) === 4