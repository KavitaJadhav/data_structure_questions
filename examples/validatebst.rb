# https://www.youtube.com/watch?v=s6ATEkipzow
# https://leetcode.com/problems/validate-binary-search-tree/
# Definition for a binary tree node.
#
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Boolean}
# ⏱ Complexity
#
# Time: O(N)
# Space: O(H)
#
def validate(node, min_left, max_right)
  return true if node.nil?

  return false if !(node.val > min_left && node.val < max_right)
  return(validate(node.left,min_left, node.val) && validate(node.right,node.val, max_right))
end

def is_valid_bst(node)
  validate(node, -Float::INFINITY, Float::INFINITY)
end