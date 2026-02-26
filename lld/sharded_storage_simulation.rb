# Consistent Hashing: Only moves ~1/N keys when adding a shard.
#
# Virtual Nodes: Each shard has multiple positions on the ring → uniform distribution.
#
# Simple Rebalance: For demo; can be optimized in production.
#
# Metrics: distribution shows keys per shard.
#

require 'digest'

# -------------------------
# 1️⃣ Shard
# -------------------------
class Shard
  attr_reader :id

  def initialize(id)
    @id = id
    @data = {}
  end

  def put(key, value)
    @data[key] = value
  end

  def get(key)
    @data[key]
  end

  def delete(key)
    @data.delete(key)
  end

  def size
    @data.size
  end

  def keys
    @data.keys
  end
end

# -------------------------
# 2️⃣ HashRing with Virtual Nodes
# -------------------------
class HashRing
  def initialize(vnodes: 100)
    @vnodes = vnodes
    @ring = {}          # hash_position => shard
    @sorted_keys = []   # sorted hash positions
  end

  def add_shard(shard)
    @vnodes.times do |i|
      vnode_key = "#{shard.id}-#{i}"
      hash = hash_value(vnode_key)
      @ring[hash] = shard
      @sorted_keys << hash
    end
    @sorted_keys.sort!
  end

  def remove_shard(shard)
    @vnodes.times do |i|
      vnode_key = "#{shard.id}-#{i}"
      hash = hash_value(vnode_key)
      @ring.delete(hash)
      @sorted_keys.delete(hash)
    end
  end

  def get_shard(key)
    return nil if @ring.empty?

    hash = hash_value(key)
    index = @sorted_keys.bsearch_index { |h| h >= hash } || 0
    shard_hash = @sorted_keys[index]
    @ring[shard_hash]
  end

  private

  def hash_value(value)
    Digest::MD5.hexdigest(value.to_s).hex
  end
end

# -------------------------
# 3️⃣ ShardedStore
# -------------------------
class ShardedStore
  def initialize(vnodes: 100)
    @ring = HashRing.new(vnodes: vnodes)
    @shards = []
  end

  def add_shard(shard)
    @shards << shard
    @ring.add_shard(shard)
    rebalance
  end

  def remove_shard(shard)
    @shards.delete(shard)
    @ring.remove_shard(shard)
    rebalance
  end

  def put(key, value)
    shard = @ring.get_shard(key)
    shard.put(key, value)
  end

  def get(key)
    shard = @ring.get_shard(key)
    shard.get(key)
  end

  def delete(key)
    shard = @ring.get_shard(key)
    shard.delete(key)
  end

  def distribution
    @shards.map { |s| [s.id, s.size] }.to_h
  end

  private

  # Simple full rebalance for demo purposes
  def rebalance
    all_data = []

    @shards.each do |shard|
      shard.keys.each do |key|
        all_data << [key, shard.get(key)]
      end
    end

    # Clear all shards
    @shards.each do |shard|
      shard.keys.each { |k| shard.delete(k) }
    end

    # Redistribute
    all_data.each do |key, value|
      put(key, value)
    end
  end
end

# -------------------------
# 4️⃣ Example Usage
# -------------------------
if __FILE__ == $0
  store = ShardedStore.new(vnodes: 50)

  s1 = Shard.new("A")
  s2 = Shard.new("B")
  s3 = Shard.new("C")

  store.add_shard(s1)
  store.add_shard(s2)
  store.add_shard(s3)

  1000.times do |i|
    store.put("key#{i}", i)
  end

  puts "Initial distribution:"
  puts store.distribution

  # Add a new shard
  s4 = Shard.new("D")
  store.add_shard(s4)

  puts "Distribution after adding shard D:"
  puts store.distribution
end