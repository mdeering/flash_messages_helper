module FlashMessagesHelper

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
     attr_accessor :css_class, :dom_id, :wrapper
     def initialize
       @css_class = lambda { |key| "#{key}" }
       @dom_id    = lambda { |key| "flash-#{key}" }
       @wrapper   = :div
     end
   end

  def self.included(target)
    target.extend ClassMethods
    target.send :include, InstanceMethods
  end

  module ClassMethods

    # Deprications
    {
      :flash_message_class_proc => :css_class,
      :flash_message_id_proc    => :dom_id,
      :flash_message_tag        => :wrapper
    }.each do |old_method, new_method|
      define_method "#{old_method}=" do |value|
        ActiveSupport::Deprecation.warn "FlashMessagesHelper.#{old_method} has been removed in favor of #{new_method}.  Please refer to the README https://github.com/mdeering/flash_messages_helper for the configuration DSL"
        FlashMessagesHelper.configure do |config|
          config.send("#{new_method}=", value)
        end
      end
    end

  end

  module InstanceMethods
    def flash_messages(options = {})
      ret = []
      flash.each do |key, value|
        ret << content_tag(FlashMessagesHelper.configuration.wrapper, value, {
            :class => FlashMessagesHelper.configuration.css_class.call(key),
            :id    => FlashMessagesHelper.configuration.dom_id.call(key)
          }.merge(options)
        )
      end
      return_string = ret.join("\n")
      return return_string.respond_to?(:html_safe) ? return_string.html_safe : return_string
    end
  end

end

ActionView::Base.send(:include, FlashMessagesHelper) if defined?(ActionView::Base)
