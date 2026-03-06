# # https://leetcode.com/problems/invert-binary-tree/
# https://www.youtube.com/watch?v=ScvTcU2Aifs
# https://leetcode.com/problems/invert-binary-tree for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {TreeNode}
#
# Complexity
# Time - o(n)
# Space - recursion stack o(log n)...o(n) if one side tree
#
#
def invert(node)
  return if node.nil?
  return if node.left.nil? && node.right.nil?
  invert(node.left)
  invert(node.right)
  node.left, node.right = node.right, node.left
end

def invert_tree(root)
  invert(root)

  root
end

# Improved Recursive Version with nil Handling
def invert_tree_improved(root)
  return nil if root.nil?  # handle nil tree

  # recursively invert left and right subtrees
  left_inverted = invert_tree(root.left)
  right_inverted = invert_tree(root.right)

  # swap left and right
  root.left, root.right = right_inverted, left_inverted

  root
end

# iterative
# Space O(1) - recursion stack avoided, but queue intruduced
def invert_tree_iterative(root)
  return nil if root.nil?

  queue = [root]

  until queue.empty?
    node = queue.shift
    # swap left and right safely
    node.left, node.right = node.right, node.left

    # enqueue children if not nil
    queue << node.left if node.left
    queue << node.right if node.right
  end

  root
end