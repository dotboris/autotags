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
  script = Pathname.new(__FILE__) + '../../autotags'
  stdint, out, status = Open3.popen2e script.to_s, *(args.map(&:to_s))

  code = status.value.exitstatus
  stdint.close
  out.autoclose = true
  code
end

def tmpdir
  path = Dir.mktmpdir
  Pathname.new path
end

def dummy_proc
  pid = Process.fork do
    sleep
  end
  Thread.new { Process.wait pid }
  pid
end

def snooze
  sleep 0.1
end

def clean_dir(dir)
  begin
    pidfile = dir + '.autotags.pid'
    if pidfile.exist?
      Process.kill :SIGTERM, pidfile.read.to_i
      snooze
    end
  rescue # rubocop:disable Lint/HandleExceptions
  end

  dir.rmtree
end

def pid_running?(pid)
  Process.kill 0, pid
  true
rescue
  false
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
