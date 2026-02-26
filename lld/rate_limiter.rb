# Base policy class
class RateLimitPolicy
  def initialize(limit:, window_size:)
    @limit = limit
    @window_size = window_size
  end

  def allow_request?(user_id)
    raise NotImplementedError, "Must implement in subclass"
  end
end

# Sliding window
class SlidingWindowPolicy < RateLimitPolicy
  def initialize(limit:, window_size:)
    super
    @buckets = {} # user_id => [timestamps]
  end

  def allow_request?(user_id)
    @buckets[user_id] ||= []
    now = Time.now
    @buckets[user_id].reject! { |t| t < now - @window_size }
    if @buckets[user_id].size < @limit
      @buckets[user_id] << now
      true
    else
      raise RateLimitExceededError, "Rate limit exceeded (Sliding Window)"
    end
  end
end

# Leaky bucket
class LeakyBucketPolicy < RateLimitPolicy
  def initialize(limit:, window_size:)
    super
    @buckets = {} # user_id => {water, last}
  end

  def allow_request?(user_id)
    now = Time.now
    bucket = @buckets[user_id] ||= { water: 0, last: now }

    leak_rate = @limit.to_f / @window_size
    elapsed = now - bucket[:last]
    bucket[:water] = [bucket[:water] - leak_rate * elapsed, 0].max
    bucket[:last] = now

    if bucket[:water] < @limit
      bucket[:water] += 1
      true
    else
      raise RateLimitExceededError, "Rate limit exceeded (Leaky Bucket)"
    end
  end
end

# Token bucket
class TokenBucketPolicy < RateLimitPolicy
  def initialize(limit:, window_size:)
    super
    @buckets = {} # user_id => {tokens, last}
  end

  def allow_request?(user_id)
    now = Time.now
    bucket = @buckets[user_id] ||= { tokens: @limit, last: now }

    refill_rate = @limit.to_f / @window_size
    elapsed = now - bucket[:last]
    bucket[:tokens] = [bucket[:tokens] + refill_rate * elapsed, @limit].min
    bucket[:last] = now

    if bucket[:tokens] >= 1
      bucket[:tokens] -= 1
      true
    else
      raise RateLimitExceededError, "Rate limit exceeded (Token Bucket)"
    end
  end
end

# Flexible RateLimiter
class RateLimiter
  POLICY_MAP = {
      sliding_window: SlidingWindowPolicy,
      leaky_bucket: LeakyBucketPolicy,
      token_bucket: TokenBucketPolicy
  }

  def initialize(policy_type:, limit:, window_size:)
    policy_class = POLICY_MAP[policy_type] || raise("Unknown policy")
    @policy = policy_class.new(limit: limit, window_size: window_size)
  end

  def allow_request?(user_id)
    @policy.allow_request?(user_id)
  end
end
