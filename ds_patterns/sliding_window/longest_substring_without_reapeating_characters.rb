Perfect — here’s a **Staff-Level Prep Sheet** specifically for **Longest Substring Without Repeating Characters**, structured like L6/Google-ready notes. This is exactly how you’d want to present it in an interview.

---

# 🏗 Longest Substring Without Repeating Characters — Staff-Level Prep Sheet

## Problem

> Given a string `s`, find the length of the **longest substring without repeating characters**.

**Examples:**

```ruby
"abcabcbb" → 3 ("abc")
"bbbbb"    → 1 ("b")
"pwwkew"   → 3 ("wke")
""         → 0
```

---

## ✅ Staff-Level Approach: Sliding Window + HashMap

**Idea:**

* Maintain a **sliding window** `[left, right]`.
* Keep a **hash map** of `char → last seen index`.
* Move `right` forward; if duplicate found, move `left` past previous occurrence.
* Track `max_len` at every step.

---

### Ruby Implementation

```ruby
def length_of_longest_substring(s)
char_index = {}  # map char -> last index seen
max_len = 0
left = 0

s.chars.each_with_index do |char, right|
if char_index.key?(char) && char_index[char] >= left
# Duplicate detected → slide left past last occurrence
left = char_index[char] + 1
end

char_index[char] = right
max_len = [max_len, right - left + 1].max
end

max_len
end
```

---

### ✅ Complexity

| Metric | Complexity                                                  |
| ------ | ----------------------------------------------------------- |
| Time   | O(N) → each character visited at most twice                 |
| Space  | O(min(N, charset_size)) → hash map stores unique characters |

---

## ⚖️ Trade-offs

| Approach                 | Pros                  | Cons                               |
| ------------------------ | --------------------- | ---------------------------------- |
| Sliding Window + HashMap | Optimal O(N), general | Extra memory for hash map          |
| Sliding Window + Set     | Slightly simpler      | Cannot track indices for substring |
| Brute Force              | Easy to write         | O(N³), infeasible for large N      |
| Array for ASCII          | O(N), O(1) access     | Limited to ASCII (128 chars)       |

---

## 🧠 Staff-Level Follow-Up / Drilling Questions

1. **Unicode / arbitrary charset:** hash map still works; array only for fixed small charset.
2. **Return substring itself:** track `start_index` along with `max_len`.
3. **All substrings of max length:** store starting indices of max-length windows.
4. **Streaming input:** sliding window works in streaming fashion.
5. **Fixed charset (ASCII):** use array of size 128 → O(1) access, less overhead.
6. **Memory optimization:** only store last-seen index per character; no need for actual substring array.

---

## 💎 L6 / Staff-Level Notes

* **Explain your sliding window choice:** O(N) reasoning and why each char is visited at most twice.
* **Edge cases:** empty string, all duplicates, all unique characters.
* **Memory trade-offs:** hash map vs array.
* **Streaming / concurrent input:** window is sufficient; no global state needed.
* **Extensions / modifications:** return substring itself, multiple substrings, or indices.
* **Discuss time-space trade-offs** for large inputs.

---

### ✅ Google/L6 Talking Points

* Sliding window + hash map is optimal.
* Edge-case handling is complete.
* Can extend to **return substrings**, **streaming**, **Unicode**, or **distributed processing**.
* Can mention **alternative implementations**: set vs array vs brute-force, and justify choice.
* Ready to discuss **trade-offs and scaling** with interviewer.

---

If you want, I can now **combine this with Top K Elements, Merge K Lists, and LRU Cache** into a **single L6 Staff-Level Prep Sheet**, so you have one **all-in-one Google-ready reference** for coding interviews.

Do you want me to do that?
