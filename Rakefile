require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

begin
  AUTHOR   = "Michael Deering"
  EMAIL    = "mdeering@mdeering.com"
  GEM      = "flash_messages_helper"
  HOMEPAGE = "http://github.com/mdeering/flash_messages_helper"
  SUMMARY  = "A simple yet configurable rails view helper for displaying flash messages."

  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.author       = AUTHOR
    s.email        = EMAIL
    s.files        = %w(install.rb install.txt MIT-LICENSE README.textile Rakefile) + Dir.glob("{rails,lib,spec}/**/*")
    s.homepage     = HOMEPAGE
    s.name         = GEM
    s.require_path = 'lib'
    s.summary      = SUMMARY
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc 'Default: spec tests.'
task :default => :spec

desc 'Test the flash_messages_helper gem.'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ["-c"]
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', '/opt,spec,Library']
end

desc 'Generate documentation for the flash_messages_helper plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FlashMessagesHelper'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
