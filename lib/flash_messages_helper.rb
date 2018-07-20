# frozen_string_literal: true

require 'flash_messages_helper/version'

module FlashMessagesHelper

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

  module InstanceMethods
    def flash_messages(options = {})
      ret = []
      flash.each do |key, value|
        ret << content_tag(FlashMessagesHelper.configuration.wrapper, value, {
          class: FlashMessagesHelper.configuration.css_class.call(key),
          id: FlashMessagesHelper.configuration.dom_id.call(key)
        }.merge(options))
      end
      return_string = ret.join("\n")
      return_string.respond_to?(:html_safe) ? return_string.html_safe : return_string
    end
  end

end

ActionView::Base.send(:include, FlashMessagesHelper) if defined?(ActionView::Base)
