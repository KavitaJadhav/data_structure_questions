# https://leetcode.com/problems/min-cost-to-connect-all-points/?envType=problem-list-v2&envId=minimum-spanning-tree&
# @param {Integer[][]} points
# @return {Integer}
#
# Complexity
# Time
# O(N square) -> adjacency list + oLog(n+e) - heap
#
require 'set'
require 'algorithms'

def min_cost_connect_points(points)
  include Containers
  p_queue = Containers::MinHeap.new
  adjacency_list = Hash.new {|h, k| h[k] = []}

  for i_index in 0..points.size - 1
    for j_index in i_index + 1..points.size - 1
      distance = (points[i_index][0] - points[j_index][0]).abs +
          (points[i_index][1] - points[j_index][1]).abs
      adjacency_list[i_index].push([distance, j_index])
      adjacency_list[j_index].push([distance, i_index])
    end
  end

  visited = Set.new
  total_cost = 0
  p_queue.push([0, 0])

  while !p_queue.empty?

    node = p_queue.pop


    unless visited.include?(node[1])

      visited.add(node[1])
      total_cost += node[0]
      adjacency_list[node[1]].each {|edge| p_queue.push(edge) unless visited.include?(edge[1])}
    end
  end
  total_cost
end

puts min_cost_connect_points([[0, 0], [2, 2], [3, 10], [5, 2], [7, 0]]) == 20