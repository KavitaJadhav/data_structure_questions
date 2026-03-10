

# 🏗 Top K Frequent Elements — Staff-Level Notes

## Problem

> Given an array of integers `nums` and an integer `k`, return the `k` most frequent elements.

**Example:**

```ruby
nums = [1,1,1,2,2,3]
k = 2
# Output: [1,2]
```

---

## ✅ 1. Standard Staff-Level Approach: Bucket Sort

### Intuition

* Count frequency of each number → `O(N)`
* Use **bucket sort**: index = frequency, each bucket contains numbers with that frequency
* Traverse buckets in reverse to pick top k → `O(N)`

### Ruby Implementation

```ruby
def top_k_frequent(nums, k)
# Step 1: Count frequency
freq_map = Hash.new(0)
nums.each { |n| freq_map[n] += 1 }

# Step 2: Bucket: frequency -> numbers
buckets = Array.new(nums.size + 1) { [] }
freq_map.each do |num, freq|
buckets[freq] << num
end

# Step 3: Collect top k from highest freq
result = []
buckets.size.downto(0) do |i|
next if buckets[i].empty?
buckets[i].each do |num|
result << num
return result if result.size == k
end
end

result
end
```

**Complexity:**

* **Time:** O(N) — counting + bucket traversal
* **Space:** O(N) — freq_map + buckets

---

## ✅ 2. Alternative: Min-Heap (Priority Queue)

### When to Use

* Useful if `k << N` (k small relative to input)
* Less memory overhead than full bucket sort for huge N

### Ruby Implementation

```ruby
require 'set'
require 'algorithms'
include Containers

def top_k_frequent_heap(nums, k)
freq_map = Hash.new(0)
nums.each { |n| freq_map[n] += 1 }

heap = Containers::PriorityQueue.new
freq_map.each do |num, freq|
heap.push(num, -freq)  # max-heap using negative frequency
end

result = []
k.times { result << heap.pop }
result
end
```

**Complexity:**

* **Time:** O(N log k)
* **Space:** O(N) for freq_map + O(k) for heap
* More efficient when k is small and N is huge

---

## ⚖️ Trade-offs

| Approach           | Time       | Space    | When Best                    |
| ------------------ | ---------- | -------- | ---------------------------- |
| Bucket sort        | O(N)       | O(N)     | k ~ N or N moderate          |
| Min-Heap           | O(N log k) | O(N + k) | k small, N huge              |
| Sorting freq array | O(N log N) | O(N)     | simple, small N, k arbitrary |

---

## 🧠 Staff-Level Drilling / Follow-Ups

1. **Drill: “What if k is very small compared to N?”**

* Min-heap approach wins (O(N log k) < O(N))

2. **Drill: “Can you do it in O(N) time?”**

* Bucket sort → linear, but depends on bounded frequency

3. **Drill: “What if the input is streaming?”**

* Keep a **running min-heap of size k**
* Allows constant space for top k elements over time
* Tradeoff: slower per-insert O(log k), memory fixed

4. **Drill: “What if multiple elements have same frequency?”**

* Define tie-breaker: smallest element first, or order doesn’t matter

5. **Drill: “What if numbers are extremely large?”**

* Use hash-map for counting → frequency mapping independent of value range

6. **Drill: “Distributed / MapReduce scenario?”**

* Count frequencies locally per shard → reduce → merge top k per shard
* O(k log k) per reducer → O(N) overall

7. **Staff-level optimizations / notes**

* In-place bucket sort if you can overwrite input array
* Sparse bucket array → only frequencies that exist
* Avoid duplicates in result when multiple numbers share same freq

---

## 💎 L6 / Staff-Level Talking Points

* Always discuss **time/space trade-offs**
* Mention **streaming / distributed scenarios**
* Consider **edge cases**: empty array, k = N, duplicates
* Mention **why bucket sort is linear**, and why heap is better for small k
* Show **parallelism potential**: frequency counting per shard/thread
* Be prepared to **draw the bucket diagram or heap diagram** — visual explanations impress interviewers

---

If you want, I can now **combine this into a single Google-ready “staff-level notes + code + diagrams” doc** for **both Top K Elements and Merge K Lists**, showing **L6 thinking patterns** for follow-ups.

Do you want me to do that?
