require "rake/testtask"

# RDocTask is deprecated, but RDoc::Task is not available in Ruby 1.8.7.
begin
  require "rdoc/task"
rescue LoadError
  require "rake/rdoctask"
end

require "bundler/setup"
Bundler.require(:test)

Rake::TestTask.new do |task|
  task.libs << "test"
end

Rake::RDocTask.new do |rdoc|
  rdoc.title = 'wait gem'
  rdoc.rdoc_files.include('lib')
end

Gokdok::Dokker.new do |gd|
  gd.repo_url = 'git@github.com:toddmazierski/wait.git'
  gd.remote_path = "./"
end

desc "Run tests"
task :default => :test
