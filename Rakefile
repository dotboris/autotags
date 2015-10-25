require 'rspec/core/rake_task'
require 'semver'
require 'open3'

RSpec::Core::RakeTask.new :spec

task default: [:spec]

def version
  SemVer.find
end

desc "Release #{version}"
task release: %w(
  spec
  release:_assert_commited
  release:tag
  release:push
)

namespace :release do
  def sh_status(command)
    stdin, stdout, status = Open3.popen2e command
    stdin.close
    stdout.autoclose = true

    status.value
  end

  task :_assert_commited do
    unless sh_status('git diff --exit-code').success? &&
           sh_status('git diff-index --quiet --cached HEAD').success?
      fail 'Working directory is not clean. Please commit/stash your changes.'
    end
  end

  desc "Tag #{version} for release"
  task :tag do
    fail "Tag #{version} already exists" \
      if `git tag`.split(/\n/).include? version.to_s

    puts "Tagging #{version}"
    system 'git', 'tag', version.to_s
  end

  desc "Push commits and tags for #{version}"
  task :push do
    puts "Pushing commits and tags for #{version}"
    sh 'git push'
    sh 'git push --tags'
  end
end
