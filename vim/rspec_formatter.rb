require 'rspec/core/formatters/base_text_formatter'

class VimFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self, :example_failed

  def initialize(output)
    @output = output
  end

  def example_failed(example)

    exception = example.exception
    path = Regexp.last_match[1] if exception.backtrace.find do |frame|
      frame =~ %r{\b(spec/.*_spec\.rb:\d+)(?::|\z)}
    end

    message = format_message exception.message

    @output.puts "#{path}: #{example_group.description.strip} " +
      "#{example.description.strip}: #{message.strip}" if path
  end

  private

  def format_message(msg)
    msg.gsub("\n", ' ')[0,200]
  end
end

