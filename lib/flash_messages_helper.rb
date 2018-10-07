# frozen_string_literal: true

require 'flash_messages_helper/version'

# Rails view helper for displaying flash messages
module FlashMessagesHelper

  # Utility class for tracking gem configuration options and defaults
  class Configuration

    attr_accessor :css_class, :dom_id, :wrapper

    def initialize
      @css_class = ->(key) { key.to_s }
      @dom_id    = ->(key) { "flash-#{key}" }
      @wrapper   = :div
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.included(target)
    target.send :include, InstanceMethods
  end

  # @todo replace this pattern with activesupport concern
  module InstanceMethods
    def flash_messages(options = {})
      flash.map do |key, value|
        content_tag(FlashMessagesHelper.configuration.wrapper, value, {
          class: FlashMessagesHelper.configuration.css_class.call(key),
          id:    FlashMessagesHelper.configuration.dom_id.call(key)
        }.merge(options))
      end.join("\n").html_safe
    end
  end

end

ActionView::Base.send(:include, FlashMessagesHelper) if defined?(ActionView::Base)
