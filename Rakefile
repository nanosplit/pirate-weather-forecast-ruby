# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.rspec_opts = ["--backtrace"]
  # spec.ruby_opts = ['-w']
end

task default: :spec

RuboCop::RakeTask.new

task default: :rubocop
