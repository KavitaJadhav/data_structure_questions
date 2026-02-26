Here are comprehensive **notes on LeetCode 79 — *Word Search*** including your own explanations, key ideas, and complexity analysis.

---

# 📌 Problem Recap

Given an `m × n` grid of characters `board` and a string `word`, determine if the word exists in the board.

Rules:

* You can move **up, down, left, or right** to adjacent cells.
* You **cannot reuse** the same cell more than once in a single path.
* If you can trace the full word, return `true`; otherwise, return `false`. ([leetcodee.com][1])

**Example:**

```
board = [
["A","B","C","E"],
["S","F","C","S"],
["A","D","E","E"]
]
word = "ABCCED"  → true
word = "SEE"     → true
word = "ABCB"    → false
```

([leetcodee.com][1])

---

# 🧠 Core Algorithm: DFS + Backtracking

We try every cell in the grid as a *starting point*.
From a start, we recursively attempt to match the word character-by-character using DFS.

At each step:

1. Check whether current character matches.
2. If match, **mark cell as visited** (either with a visited matrix or temporarily overwrite the grid).
3. Recursively try the 4 neighbors.
4. If path doesn’t work out, **backtrack** (restore visited state). ([algomap.io][2])

Pseudocode idea:

```
for each cell (i,j):
if dfs(i, j, 0):
return true

return false
```

```
dfs(i, j, index):
if index == word.length:
return true
if out of bounds OR board[i][j] != word[index]:
return false

mark visited
result = dfs in 4 directions
restore visited

return result
```

---

# 📊 Time Complexity

The dominant cost comes from:

1. Checking all starting positions `m × n`
2. For each position, exploring up to 4 directions per step for each character of length `L`

In the *worst case*:

* All grid cells match the first character.
* Each DFS can branch up to 4 directions initially, and up to 3 directions after because you can’t return to the immediate previous cell. ([algomap.io][2])

### Worst-case time:

[
O(m \times n \times 3^L)
]
or loosely:
[
O(\text{number of cells} × 4^{\text{word length}})
]

Both are exponential in the length of the word, typical of backtracking. ([leetcodee.com][1])

---

# 📉 Space Complexity

Space is dominated by the recursion stack and path:

[
O(L)
]

Where `L` is the length of the word (maximum recursion depth). ([leetcodee.com][1])

Extra memory for visited tracking depends on your approach:

* In-place marking → no extra grid
* Boolean visited grid → `O(m × n)`

---

# 🛠️ Optimization / Early Pruning (Optional)

To make practical performance better under some scenarios:

* If `word.length > m × n`, short circuit → return false.
* Count characters: if the word has more of a particular character than the grid has, early reject.
* For performance: start search from less frequent characters first (optional heuristic). ([Medium][3])

Even with pruning, the *worst-case* complexity remains exponential in `L`.

---

# 🧪 Edge Cases To Remember

✔ Single cell grid
✔ Word length 1
✔ Multiple potential starting points
✔ Matching paths that fail late in the word — backtracking handles this
✔ Cases where grid contains duplicates but visit rules block reuse ([algomap.io][2])

---

# 📌 Summary Notes

**Algorithm:** Depth‑First Search (DFS) with Backtracking
**Time Complexity:**
[
O(m \times n \times 3^L)
]
(where `L` = word length) ([algomap.io][2])

**Space Complexity:**
[
O(L)
]
(due to recursion) ([leetcodee.com][1])

**Key Insight:**
Backtracking explores all paths from each start cell, pruning dead paths early and restoring state after exploring each possibility.

---

If you want, I can also provide a **Ruby implementation** with visited tracking and pruning explained. Let me know!

[1]: https://leetcodee.com/problems/word-search/?utm_source=chatgpt.com "Word Search - LeetCodee"
[2]: https://algomap.io/problems/word-search?utm_source=chatgpt.com "Word Search - Leetcode Solution"
[3]: https://medium.com/%40tabassum_k/79-word-search-leetcode-22b155ce226?utm_source=chatgpt.com "Word Search - LeetCode | Medium"
