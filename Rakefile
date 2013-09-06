require 'puppetlabs_spec_helper/rake_tasks'

task :default => [:lint, :spec]

desc "Run all tasks for a release"
task :release => [:clean, :spec_clean, :build]
