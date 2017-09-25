class Wait
  class BaseCounter
    attr_accessor :logger
    attr_reader   :attempt

    def initialize(total)
      # Attempt to prevent causing an infinite loop by being very strict about
      # the value passed.
      unless total.is_a?(Integer) and total > 0
        raise(ArgumentError, "invalid number of attempts: #{total.inspect}")
      end

      @total = total
    end

    # Called before all attempts to reset the counter.
    def reset
      @attempt = 0
    end

    # Called before each attempt to increment the counter.
    def increment
      @attempt += 1
      log
    end

    # Returns +true+ if this is the last attempt.
    def last_attempt?
      @attempt == @total
    end

    # Logs the current attempt count.
    def log
      return if @logger.nil?

      @logger.debug("Counter") { "attempt #{self}" }
    end

    # Returns a string representation of the current count.
    def to_s
      [@attempt, @total].join("/")
    end
  end # BaseCounter
end # Wait
