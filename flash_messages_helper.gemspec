# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'flash_messages_helper/version'

Gem::Specification.new do |s|
  s.name        = 'flash_messages_helper'
  s.version     = FlashMessagesHelper::Version
  s.authors     = ['Michael Deering']
  s.email       = ['mdeering@mdeering.com']
  s.homepage    = 'https://github.com/mdeering/flash_messages_helper'
  s.summary     = 'A configurable Ruby on Rails view helper for displaying html flash messages in your Rails applications.'

  s.files = Dir['{lib}/**/*']
  s.require_paths = ['lib']

  s.add_runtime_dependency 'actionview'

end
