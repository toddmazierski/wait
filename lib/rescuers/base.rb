class Wait
  class BaseRescuer
    attr_accessor :logger
    attr_reader   :exceptions

    def initialize(exceptions)
      @exceptions = Array(exceptions).flatten
    end

    # Logs an exception.
    def log(exception)
      return if @logger.nil?

      klass = exception.class.name
      # We can omit the message if it's identical to the class name.
      message = exception.message unless exception.message == klass
      # Indent the exception so it stands apart from the rest of the messages.
      backtrace = indent(exception.backtrace)

      @logger.debug("Rescuer") { "rescued: #{klass}#{": #{message}" if message}\n#{backtrace}" }
    end

    # Indents text a given number of spaces.
    def indent(lines, spaces = 25)
      lines.map { |line| (" " * spaces) + line }.join("\n")
    end
  end # BaseRescuer
end # Wait
