module FlashMessagesHelper

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
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
    # target.cattr_accessor :flash_message_class_proc
    # target.flash_message_class_proc = lambda { |key| "#{key}" }
    # target.cattr_accessor :flash_message_id_proc
    # target.flash_message_id_proc = lambda { |key| "flash-#{key}" }
    # target.cattr_accessor :flash_message_tag
    # target.flash_message_tag     = :div
    target.extend ClassMethods
    target.send :include, InstanceMethods
  end

  module ClassMethods
    def flash_message_class_proc=(value)
      # TODO: Deprication Warning!
      FlashMessagesHelper.configure do |c|
        c.css_class = value
      end
    end
    def flash_message_id_proc=(value)
      # TODO: Deprication Warning!
      FlashMessagesHelper.configure do |c|
        c.dom_id = value
      end
    end
    def flash_message_tag=(value)
      # TODO: Deprication Warning!
      FlashMessagesHelper.configure do |c|
        c.wrapper = value
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
      return ret.join("\n")
    end
  end

end

ActionView::Base.send(:include, FlashMessagesHelper) if defined?(ActionView::Base)
