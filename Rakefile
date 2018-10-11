# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names']
end

require 'yardstick/rake/verify'
require 'mdeering/style'
require 'yaml'

yardstick_options = YAML.load_file(Mdeering::Style.yardstick)
Yardstick::Rake::Verify.new(:yardstick, yardstick_options)

task default: [:rubocop, :spec, :yardstick]
