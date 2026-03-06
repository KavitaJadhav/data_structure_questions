## 🧵 GVL (Global VM Lock) in Ruby

GVL = **Global VM Lock**
                      It exists in **MRI** (also called CRuby).

    ---

# 🔹 What Is GVL?

GVL is a **mutex inside the Ruby interpreter** that allows **only one thread to execute Ruby code at a time**, even on multi-core CPUs.

    So even if you create:

                       ```ruby
Thread.new { heavy_computation }
Thread.new { heavy_computation }
```

Only **one thread runs Ruby bytecode at a time**.

    ---

# 🔹 Why Does Ruby Have GVL?

Main reasons:

    1. Simpler memory management
2. Easier garbage collection
3. Thread safety inside C extensions
4. Faster context switching than fine-grained locks

It reduces complexity of interpreter internals.

    ---

# 🔹 Important: GVL ≠ No Concurrency

GVL blocks **parallel CPU execution**, but allows:

### ✅ IO Concurrency

                                               If thread is waiting for:

* network
* file IO
* database
* sleep

Ruby releases the GVL.

    Example:

    ```ruby
Thread.new { Net::HTTP.get(...) }
Thread.new { Net::HTTP.get(...) }
```

These can overlap because IO releases GVL.

    ---

# 🔹 CPU-bound vs IO-bound

| Type                    | GVL Impact         |
| ----------------------- | ------------------ |
| CPU-bound (math, loops) | ❌ No parallelism   |
| IO-bound (HTTP, DB)     | ✅ Good concurrency |

                                       ---

# 🔹 Comparison to Python

                                       Very similar to:

* Python’s GIL (Global Interpreter Lock)

Same trade-off:

    * Easier interpreter design
* No true multi-core CPU parallelism

---

# 🔹 How to Get True Parallelism in Ruby?

### 1️⃣ Use Processes (Preferred in MRI)

```ruby
fork do
  heavy_work
end
```

Used by:

* Puma (cluster mode)
* Sidekiq

Each process has its own GVL.

    ---

### 2️⃣ Use JRuby

* **JRuby**
* No GVL
* Real parallel threads

---

### 3️⃣ Use Ractors (Ruby 3+)

Ractors allow parallelism with object isolation.

    But:

    * Strict object sharing rules
* More complex

---

# 🔹 How This Affects System Design Interviews

If interviewer asks:

> "Why doesn't Ruby scale well for CPU-heavy tasks?"

Answer:

    * MRI has GVL → only one thread executes Ruby bytecode at a time.
        * Use multi-process or JRuby for CPU-bound parallelism.

    If asked:

> "How would you scale a Ruby web server?"

Correct answer:

* Use multi-process (Puma workers)
* Behind load balancer
* Horizontal scaling

---

# 🔹 Visualization

```
CPU Core 1  ─┐
CPU Core 2  ─┤  → Only 1 thread runs Ruby at once
CPU Core 3  ─┤
CPU Core 4  ─┘
```

But for IO:

      ```
Thread 1: waiting HTTP
Thread 2: waiting DB
Thread 3: running Ruby
```

      ---

# 🔥 Staff-Level Insight

      GVL improves:

          * Predictability
          * Simpler GC
      * Lower memory overhead

      But hurts:

      * CPU-bound workloads
      * High-performance compute systems

      That’s why Ruby is great for:

      * Web apps
      * IO-heavy systems

      But not ideal for:

      * High-performance numerical computing

      ---

      If you'd like, I can next explain:

* How Puma uses threads + workers
* How Sidekiq works with Redis + processes
* Or deep dive into Ruby memory model + GC

Given your interview prep, understanding GVL well is a strong signal.
