require 'open3'
require 'pathname'

def autotags(command, path = nil, verbose: false)
  args = []
  args << '-v' if verbose
  args << command
  args << path if path

  raw_autotags(*args)
end

def raw_autotags(*args)
  status = nil
  Dir.chdir Pathname.new(__FILE__) + '../..' do
    _, status = Open3.capture2e './autotags', *(args.map(&:to_s))
  end
  status.exitstatus
end

def tmpdir
  path = Dir.mktmpdir
  Pathname.new path
end

def dummy_proc
  Process.fork do
    sleep
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
