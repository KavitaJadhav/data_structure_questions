# Full graph (All nodes connected to each other)
# No adjacency list needed as distance can be computed during traversal

# Without heap
def _min_cost_connect_points(points)
  n = points.length
  visited = Array.new(n, false)
  min_dist = Array.new(n, Float::INFINITY)

  min_dist[0] = 0
  total_cost = 0

  n.times do
    # Pick unvisited node with smallest distance
    u = -1
    n.times do |i|
      if !visited[i] && (u == -1 || min_dist[i] < min_dist[u])
        u = i
      end
    end

    visited[u] = true
    total_cost += min_dist[u]

    # Update distances
    n.times do |v|
      next if visited[v]

      dist = (points[u][0] - points[v][0]).abs +
          (points[u][1] - points[v][1]).abs

      min_dist[v] = [min_dist[v], dist].min
    end
  end

  total_cost
end



require 'algorithms'
include Containers
# With heap from gem

def min_cost_connect_points(points)
  n = points.length
  visited = Array.new(n, false)
  heap = MinHeap.new

  heap.push([0, 0])  # cost, node
  total_cost = 0

  until heap.empty?
    cost, node = heap.pop
    next if visited[node]

    visited[node] = true
    total_cost += cost

    n.times do |i|
      next if visited[i]
      dist = (points[node][0] - points[i][0]).abs +
          (points[node][1] - points[i][1]).abs
      heap.push([dist, i])
    end
  end

  total_cost
end