=begin
CacheLevel interface

InMemoryCache (LRU, L1)

SimulatedRedisCache (L2)

MultiLevelCache (supports cache-aside, write-through, write-back)
=end

require 'digest'

# -------------------------
# 1️⃣ Base Interface
# -------------------------
class CacheLevel
  def get(key)
    raise NotImplementedError
  end

  def put(key, value)
    raise NotImplementedError
  end

  def delete(key)
    raise NotImplementedError
  end
end

# -------------------------
# 2️⃣ In-Memory LRU Cache (L1)
# -------------------------
class LRUNode
  attr_accessor :key, :value, :prev, :next

  def initialize(key, value)
    @key = key
    @value = value
    @prev = nil
    @next = nil
  end
end

class InMemoryCache < CacheLevel
  def initialize(capacity)
    @capacity = capacity
    @map = {}
    @head = LRUNode.new(nil, nil)
    @tail = LRUNode.new(nil, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def get(key)
    node = @map[key]
    return nil unless node
    move_to_front(node)
    node.value
  end

  def put(key, value)
    if @map[key]
      node = @map[key]
      node.value = value
      move_to_front(node)
    else
      node = LRUNode.new(key, value)
      @map[key] = node
      add_to_front(node)
      evict if @map.size > @capacity
    end
  end

  def delete(key)
    node = @map.delete(key)
    remove(node) if node
  end

  private

  def add_to_front(node)
    node.next = @head.next
    node.prev = @head
    @head.next.prev = node
    @head.next = node
  end

  def remove(node)
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def move_to_front(node)
    remove(node)
    add_to_front(node)
  end

  def evict
    lru = @tail.prev
    remove(lru)
    @map.delete(lru.key)
  end
end

# -------------------------
# 3️⃣ Simulated L2 Cache (Redis)
# -------------------------
class SimulatedRedisCache < CacheLevel
  def initialize
    @store = {}
  end

  def get(key)
    sleep(0.01) # simulate network latency
    @store[key]
  end

  def put(key, value)
    sleep(0.01)
    @store[key] = value
  end

  def delete(key)
    @store.delete(key)
  end
end

# -------------------------
# 4️⃣ Multi-Level Cache
# -------------------------
class MultiLevelCache
  def initialize(levels, strategy: :cache_aside)
    @levels = levels
    @strategy = strategy
    @write_buffer = []
  end

  # ---------------------
  # READ
  # ---------------------
  def get(key)
    @levels.each_with_index do |level, index|
      value = level.get(key)
      if value
        promote(key, value, index)
        return value
      end
    end
    nil
  end

  # ---------------------
  # WRITE
  # ---------------------
  def put(key, value)
    case @strategy
    when :cache_aside
      @levels.each { |level| level.put(key, value) }

    when :write_through
      @levels.each { |level| level.put(key, value) }

    when :write_back
      @levels.first.put(key, value)
      @write_buffer << [key, value]
      async_flush
    else
      raise "Unknown strategy"
    end
  end

  def delete(key)
    @levels.each { |level| level.delete(key) }
  end

  private

  # Promote value to upper levels if found in lower level
  def promote(key, value, level_index)
    return if level_index == 0
    @levels[0...level_index].each { |level| level.put(key, value) }
  end

  # Async flush for write-back
  def async_flush
    Thread.new do
      while (entry = @write_buffer.shift)
        @levels[1..-1].each { |level| level.put(entry[0], entry[1]) }
      end
    end
  end
end

# -------------------------
# 5️⃣ Example Usage
# -------------------------
if __FILE__ == $0
  l1 = InMemoryCache.new(3)      # L1 capacity = 3
  l2 = SimulatedRedisCache.new    # L2

  cache = MultiLevelCache.new([l1, l2], strategy: :write_back)

  cache.put("a", 100)
  cache.put("b", 200)
  cache.put("c", 300)

  puts cache.get("a")  # => 100
  puts cache.get("b")  # => 200

  cache.put("d", 400)  # L1 evicts oldest key "a"
  puts cache.get("a")  # Promoted from L2 → 100
end