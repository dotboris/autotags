require 'rspec/core/rake_task'
require 'semver'
require 'open3'
require 'github_api'
require 'highline/import'

HighLine.colorize_strings

RSpec::Core::RakeTask.new :spec

def warn(message)
  say "WARNING: #{message}".color :yellow
end

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
  release:github_release
  release:bin
)

namespace :release do
  def sh_status(command)
    stdin, stdout, status = Open3.popen2e command
    stdin.close
    stdout.autoclose = true

    status.value
  end

  def github
    Github.new oauth_token: File.read('.github-token')
  end

  def gh_release_exist?
    !gh_release.nil?
  end

  def gh_repo
    %w(beraboris autotags)
  end

  def gh_release
    github.repos.releases.list(*gh_repo)
      .find { |r| r.tag_name == version.to_s }
  end

  def push_release_asset(file)
    say "Pushing '#{file}' to #{version} release".color :green
    release = gh_release

    existing_asset = release.assets.find { |a| a.name == file }
    if existing_asset
      warn "'#{file}' already exists. Removing it first."
      github.repos.releases.assets.delete(*gh_repo, existing_asset.id)
    end

    github.repos.releases.assets.upload(*gh_repo, release.id, file, name: file)
  end

  file '.github-token' do
    username = ask 'Github Username:'
    password = ask('Github Password:') { |q| q.echo = false }

    gh = Github.new basic_auth: "#{username}:#{password}"

    auth = gh.oauth.list.find { |a| a.note == 'autotags-release' }
    gh.oauth.delete auth.id if auth

    auth = gh.oauth.create note: 'autotags-release',
                           scopes: ['repo']

    p auth
    File.write '.github-token', auth.token
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

    say "Tagging #{version}".color :green
    system 'git', 'tag', version.to_s
  end

  desc "Push commits and tags for #{version}"
  task :push do
    say "Pushing commits and tags for #{version}".color :green
    sh 'git push'
    sh 'git push --tags'
  end

  desc "Create a github release for #{version}"
  task github_release: ['.github-token'] do
    say "Creating github release for #{version}".color :green
    if gh_release_exist?
      warn "Github release for #{version} already exists. Not creating."
    else
      github.repos.releases.create(*gh_repo, version.to_s)
    end
  end

  desc "Push the autotags script for #{version}"
  task bin: ['.github-token'] do
    push_release_asset 'autotags'
  end
end
