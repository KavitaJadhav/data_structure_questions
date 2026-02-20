# LRU Cache

# Todo:
# implement thread safety
# implement private struct
# Adding existing key - optimise by moving existing node in the front
#
require 'byebug'


class LRUCache
  class Node
    attr_accessor :next, :previous, :key, :value

    def initialize(key, value)
      @key = key
      @value = value
      @previous = nil
      @next = nil
    end
  end

  def initialize(capacity)
    @capacity = capacity
    @cache_map = {}

    @head = LRUCache::Node.new(nil, nil)
    @tail = LRUCache::Node.new(nil, nil)
    @head.next = @tail
    @tail.previous = @head
  end

  def put(key, value)
    node = @cache_map[key]

    if node
      node.value = value
      move_to_front(node)
    else
      evict_if_full

      node = LRUCache::Node.new(key, value)
      @cache.add_to_front(node)
      @cache_map[key] = node
    end
  end

  def get(key)
    node = @cache_map[key]
    if node
      move_to_front(node)
      node.value
    end
  end

  def to_h
    node = @head
    values = {}

    loop do
      node = node.next
      break if node == @tail
      values[node.key] = node.value
    end
    values
  end

  private

  def full?
    @cache_map.size == @capacity
  end


  def move_to_front(node)
    next_node = node.next
    previous_node = node.previous

    next_node.previous = node.previous
    previous_node.next = node.next

    add_to_front(node)
  end

  def add_to_front(node)
    next_node = @head.next
    next_node.previous = node
    node.next = next_node
    node.previous = @head
    @head.next = node
  end


  def evict_if_full
    return unless full?

    node = @tail.previous
    previous_node = node.previous

    previous_node.next = @tail
    @tail.previous = previous_node

    @cache_map.delete(node.key)

    node.next = nil
    node.previous = nil
    node
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
