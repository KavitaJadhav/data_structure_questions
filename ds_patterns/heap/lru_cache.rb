# Note.. Use optimized version

# LRU Cache

# Todo:
# implement thread safety
# implement private struct
# Adding existing key - optimise by moving existing node in the front
#
require 'byebug'
class Node
  attr_accessor :next, :previous, :key, :value

  def initialize(key, value)
    @key = key
    @value = value
    @previous = nil
    @next = nil
  end
end

class LinkedList
  def initialize
    @head = Node.new(nil, nil)
    @tail = Node.new(nil, nil)
    @head.next = @tail
    @tail.previous = @head
  end

  def add_to_front(node)
    next_node = @head.next
    next_node.previous = node
    node.next = next_node
    node.previous = @head
    @head.next = node
  end

  def move_to_front(node)
    next_node = node.next
    previous_node = node.previous

    next_node.previous = node.previous
    previous_node.next = node.next

    add_to_front(node)
  end

  def evict
    node = @tail.previous
    previous_node = node.previous

    previous_node.next = @tail
    @tail.previous = previous_node

    node.next = nil
    node.previous = nil
    node
  end

  def read
    node = @head
    values = {}

    loop do
      node = node.next
      break if node == @tail
      values[node.key] = node.value
    end
    values
  end
end

class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = LinkedList.new()
    @cache_map = {}
  end

  def put(key, value)
    node = @cache_map[key]

    if node
      @cache.move_to_front(node)
    else
      if full?
        node = @cache.evict
        @cache_map.delete(node.key)
      end

      node = Node.new(key, value)
      @cache.add_to_front(node)
      @cache_map[key] = node
    end
  end

  def get(key)
    node = @cache_map[key]
    if node
      @cache.move_to_front(node)
      node.value
    else
      nil
    end
  end

  def pairs
    @cache.read
  end

  private

  def full?
    @cache_map.size == @capacity
  end
end

lru_cache = LRUCache.new(2)
lru_cache.put(1, 'one')
lru_cache.put(2, 'two')
lru_cache.get(1)
lru_cache.put(3, 'three')
lru_cache.get(1)
lru_cache.put(3, 'three')
lru_cache.put(4, 'four')
lru_cache.get(4)
lru_cache.put(5, 'five')

puts lru_cache.pairs
