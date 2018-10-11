# frozen_string_literal: true

require 'flash_messages_helper/version'

# Rails view helper for displaying flash messages
module FlashMessagesHelper

  # Utility class for tracking gem configuration options and defaults
  class Configuration
    # css class(s) to give the wrapping element
    #
    # @example
    #   FlashMessagesHelper.configure do |config|
    #     config.css_classes = ->(key) { key.to_s }
    #   end
    #
    # @return [Proc] will be called with the flash key
    attr_accessor :css_class

    # id attribute to give the wrapping element
    #
    # @example
    #   FlashMessagesHelper.configure do |config|
    #     config.dom_id = ->(key) { "flash-#{key}" }
    #   end
    #
    # @return [Proc] will be called with the flash key
    attr_accessor :dom_id

    # Wrapper element to use
    #
    # @example
    #   FlashMessagesHelper.configure do |config|
    #     config.css_classes = :div
    #   end
    #
    # @return [String || Symbol]
    attr_accessor :wrapper

    # Setup default configuration settings for new instance
    #
    # @example
    #  @configuration ||= Configuration.new
    #
    # @return [FlashMessagesHelper::Configuration]
    def initialize
      @css_class = ->(key) { key.to_s }
      @dom_id    = ->(key) { "flash-#{key}" }
      @wrapper   = :div
    end
  end

  # Getter and initializer for configuration utility class
  #
  # @example
  #   FlashMessagesHelper.configuration.css_class.call(key),
  #
  # @return [FlashMessagesHelper::Configuration]
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Pragmatic access to configuration options
  #
  # @example
  #   FlashMessagesHelper.configure do |config|
  #     config.css_classes = :div
  #   end
  #
  # @return [void]
  def self.configure
    yield(configuration)
  end

  # Is only a single view helper at this time
  module ViewHelper
    extend ActiveSupport::Concern

    # view helper for rendering the flash messages
    #
    # @example
    #   <%= flash_messages %>
    #
    # @return [String] an html safe string for rendering
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

ActionView::Base.send(:include, FlashMessagesHelper::ViewHelper) if defined?(ActionView::Base)
