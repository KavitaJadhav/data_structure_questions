require 'byebug'

# What is happening here

# def connected_componenets(edges, count)
# puts connected_componenets([[0, 1], [1, 2], [3, 4]], 5) == 2
# Idea here is merge connected nodes to reduce total components


# total nodes are count - 5
# connected nodes are
#   - 0---1
#   - 1---2
#   - 3---4

# Union method
# Find parents of both node
# connect node to each other based on higher rank- parent with most child. i.e. Small component is becoming child of large component.
# it finds parent of each component at this point. initially all nodes are parents of itself.
# if parents are same that means components are already connected.
#
# 0----1----2
# 2---4

def connected_componenets(edges, count)
#   create a list of indivisual componenets. each componenet is a parent of itself
# [1,2,3,4,5]
# [1,1,1,1,1]
  parents = Array.new(count) {|i| i}
  rank = Array.new(count, 1)

  # find = -> (node) do
  #   parent = node
  #   while parent != parents[parent]
  #     parent = parents[parent]
  #   end
  #   parent
  # end
  # Optimized for path compression using recursion

  find = -> (node) do
    if parents[node] != node
      parents[node] = find.call(parents[node])
    end
    parents[node]
  end

  union = ->(node1, node2) do
    # byebug
    parent1 = find.call(node1)
    parent2 = find.call(node2)

    return 0 if parent1 == parent2

    if rank[parent1] > rank[parent2]
      parents[parent2] = parent1
    elsif rank[parent1] < rank[parent2]
      parents[node1] = parent2
    else
      parents[parent2] = parent1
      rank[parent1] += 1
    end

    return 1
  end

  components = count
  edges.each do |edge|
    components -= union.call(edge[0], edge[1])
  end

  components

# create a result to count childs of componenets
# for each edge, find parent
#   if parent is same. componenet is already connected. total components count remain the same
#   if parent is different - then find component parent and reduce component count
#   node parent large - rank/depth or size - attach another component

# find - > find parent
# Union -> find union- merge nodes or return 0

end

puts connected_componenets([[0, 1], [1, 2], [3, 4]], 5) == 2