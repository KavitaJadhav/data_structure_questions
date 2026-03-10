Here’s a **comprehensive set of notes for [LeetCode 212 — Word Search II](https://leetcode.com/problems/word-search-ii/)**: problem summary, algorithms, complexity, and deeper insights for system‑level thinking including scaling, streaming, and alternate data structures. ([leetcodee.com][1])

---

# ✨ **Problem Summary (LeetCode 212 — Word Search II)**

You’re given:

* An `m × n` grid of lowercase letters
* A list `words` of strings

Return **all words** from the list that can be formed by a path of **adjacent** cells (up/down/left/right).
Each cell may be used **only once per word**.
All `words[i]` are unique. ([leetcodee.com][1])

**Example:**

```
board = [
["o","a","a","n"],
["e","t","a","e"],
["i","h","k","r"],
["i","f","l","v"]
]
words = ["oath","pea","eat","rain"]
Output: ["eat","oath"]
```

([leetcode.doocs.org][2])

---

# 🧠 **Core Algorithm — Trie + DFS Backtracking**

## Why Not Brute Force Every Word?

Naively searching each word separately with DFS from every cell would be:

[
O(W × m × n × 4^L)
]

where

* `W` = number of words
* `L` = length of a word
* exploring up to 4 directions per step

This is extremely slow when `W` is large (up to 30,000). ([algomaster.io][3])

---

## 1️⃣ Build a Trie (Prefix Tree)

Insert all `words` into a Trie — a tree that stores all prefixes of the list.

* Each node has up to 26 children (letters a–z)
* Nodes can mark the end of a word
* Sum of lengths of all words = `K`

Space: `O(K)` for the Trie. ([leetcodee.com][1])

Benefits:

* Quick prefix checks
* We can prune DFS early when no word has a given prefix

---

## 2️⃣ DFS from Each Cell with Trie Guidance

For each cell in the board:

1. Check if the letter matches a child of the root Trie node
2. If yes, do DFS from this cell
3. During DFS, move down the Trie
4. Mark visited cells (e.g., temporarily change char to `#`)
5. If node indicates end of word → add to results
6. Backtrack restore visited state

This shared DFS avoids repeating search paths for multiple words.

---

# 📈 **Time Complexity**

### Worst‑case

[
O(m × n × 4^L)
]

Why?

* Try every cell → `m × n`
* In worst case, DFS from a cell explores 4 neighbors
* DFS can go as deep as the longest word length `L`

Unlike Word Search I, the effective branching factor is 4 (not discounted to 3) because we’re exploring many possible prefixes from the Trie. ([leetcode.doocs.org][2])

### More precise

A tighter bound seen in some detailed analyses:

[
O(m × n × 4 × 3^{L-1})
]

But for Big‑O interviews it’s often described simply as:

[
\boxed{O(m × n × 4^L)}
]

Pruning from the Trie usually **cuts off many invalid paths early** in practice. ([neetcode.io][4])

---

# 🧠 **Space Complexity**

Total additional space:

* Trie: `O(K)` — sum of lengths of all words
* DFS recursion stack: `O(L)` — max depth
* Board marking: `O(1)` extra if done in place

Overall:

[
O(K + L)
]

---

# 🏷 **Algorithm Notes / Optimizations**

### Early Pruning

* If a prefix isn’t in the Trie → stop DFS
* Remove words from Trie once found to avoid duplicates and dead branches
* Useful when `words` contains many similar prefixes ([neetcode.io][4])

### Visited Marking

Two approaches:

1. Temporary board marking (easiest)
2. Separate `visited` array

Both avoid revisiting the same cell in one path.

---

## ✔ Edge Cases

* Board of size 1×1
* Words longer than total cells
* High density of duplicates in grid
* Words that overlap heavily

---

# 🧰 Alternative Data Structures

| Structure                                    | Use Case                               | Tradeoff                     |
| -------------------------------------------- | -------------------------------------- | ---------------------------- |
| **Trie**                                     | Efficient prefix pruning               | Extra memory `O(K)`          |
| **Hash Set / Map per prefix**                | Fast lookup if prefix list precomputed | High space, slow build       |
| **Suffix automaton / DAWG**                  | Compressed prefix structures           | Complex to implement         |
| **Bitmask caching / caching visited states** | Performance tricks in grid             | Hard to maintain correctness |

Trie is the dominant practical choice for Word Search II.

---

# 📊 **Scaling & Performance in Practice**

### What makes the problem difficult?

* `words` can be large (30,000)
* `board` small but DFS deep
* Many similar prefixes produce heavy recursion

Trie pruning is essential to reduce search paths. Without it, brute DFS is too slow. ([algomaster.io][3])

---

# 🤝 **Streaming & Distributed Systems Angle**

This problem is not inherently *streaming*‑friendly or easily *distributed*, but we can imagine extensions:

---

## 🔹 **Streaming Words**

If words arrive in a stream:

* Build the Trie incrementally
* Maintain incremental results
* Use sliding window techniques or online DFS-like processing

Challenges:

* Shared state (Trie) gets bigger
* Increase in pruning coverage helps but makes updates costly

Streaming edges still require DFS over local grid.

---

## 🔹 **Distributed Board Search**

If board is large (imagine a huge grid):

1. **Partition the board** into chunks
2. Each worker:

* Holds a section of the grid
* Searches locally
* Communicates edge paths to neighbors

Issues:

* Words can cross partition boundaries
* Need extra boundary states
* Requires merging partial matches

This is similar to distributed pattern search or distributed prefix search.

---

# 🧠 **Comparison to Word Search I**

| Feature         | Word Search I      | Word Search II            |
| --------------- | ------------------ | ------------------------- |
| Input           | One word           | Many words                |
| Strategy        | DFS per start      | Trie + DFS                |
| Brute Force     | feasible           | too slow                  |
| Time Complexity | `O(mn3^L)`         | `O(mn4^L)` pruned by Trie |
| Optimal         | DFS + backtracking | Trie + DFS                |

Word Search II builds on the first but adds the **multiple words / prefix search dimension**.

---

# 🧑‍💻 Interview‑Level Summary

* Use a **Trie** to store the list of words — allows prefix pruning
* DFS from each grid cell, guided by Trie
* Prune early when no prefix matches
* Break recursion on visited cells
* Best practical time near `O(m × n × 4^L)`
* Space dominated by Trie

Saying this concisely in an interview positions you well:

> “We build a Trie and do DFS from each cell, pruning invalid prefixes. Worst‑case time is (O(m×n×4^L)) with space (O(K+L)).” ([leetcode.doocs.org][2])

---

If you want, I can also produce a **Ruby implementation** and **debug walkthrough** of an example input step‑by‑step.

[1]: https://leetcodee.com/problems/word-search-ii/?utm_source=chatgpt.com "Word Search II - LeetCodee"
[2]: https://leetcode.doocs.org/en/lc/212/?utm_source=chatgpt.com "212. Word Search II - LeetCode Wiki"
[3]: https://algomaster.io/learn/dsa/word-search-ii?utm_source=chatgpt.com "Word Search Ii | DSA | AlgoMaster.io | AlgoMaster.io"
[4]: https://neetcode.io/solutions/word-search-ii?utm_source=chatgpt.com "212. Word Search II - Solution & Explanation"
