require 'thread'
require 'time'
require 'securerandom'

# --- Exceptions are as defined above ---

# --- Task class ---
class Task
  attr_accessor :id, :run_at, :priority, :status, :retries, :block

  def initialize(run_at:, priority: 0, &block)
    @id = SecureRandom.uuid
    @run_at = run_at
    @priority = priority
    @block = block
    @status = :pending
    @retries = 0
  end
end

# --- Task Queue ---
class TaskQueue
  def initialize
    @queue = []
    @mutex = Mutex.new
  end

  def add(task)
    @mutex.synchronize do
      raise TaskAlreadyExistsError, "Task #{task.id} already exists" if @queue.any? { |t| t.id == task.id }
      @queue << task
      # Sort by run_at then priority (lower number = higher priority)
      @queue.sort_by! { |t| [t.run_at, -t.priority] }
    end
  end

  def pop_ready
    @mutex.synchronize do
      now = Time.now
      ready_tasks = @queue.select { |t| t.run_at <= now && t.status == :pending }
      ready_tasks.each { |t| t.status = :running }
      @queue -= ready_tasks
      ready_tasks
    end
  end

  def cancel(task_id)
    @mutex.synchronize do
      task = @queue.find { |t| t.id == task_id }
      raise TaskNotFoundError, "Task not found" if task.nil?
      task.status = :cancelled
      @queue.delete(task)
    end
  end

  def list
    @mutex.synchronize { @queue.map { |t| { id: t.id, run_at: t.run_at, priority: t.priority, status: t.status } } }
  end
end

# --- Task Scheduler ---
class TaskScheduler
  attr_reader :queue

  def initialize
    @queue = TaskQueue.new
    @running = false
  end

  # Schedule a task
  def schedule(run_at: Time.now, priority: 0, &block)
    task = Task.new(run_at: run_at, priority: priority, &block)
    @queue.add(task)
    task
  end

  # Cancel a task
  def cancel(task_id)
    @queue.cancel(task_id)
  end

  # List tasks
  def list
    @queue.list
  end

  # Start the scheduler loop (runs in separate thread)
  def start
    @running = true
    Thread.new do
      while @running
        ready_tasks = @queue.pop_ready
        ready_tasks.each do |task|
          begin
            task.block.call
            task.status = :completed
          rescue => e
            task.status = :failed
            task.retries += 1
            puts "Task #{task.id} failed: #{e.message}"
          end
        end
        sleep(0.1) # avoid busy-wait
      end
    end
  end

  # Stop scheduler
  def stop
    @running = false
  end
end