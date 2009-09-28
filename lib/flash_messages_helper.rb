module FlashMessagesHelper

  def self.included(target)
    target.cattr_accessor :flash_message_class_proc
    target.flash_message_class_proc = lambda { |key| "#{key}" }
    target.cattr_accessor :flash_message_id_proc
    target.flash_message_id_proc = lambda { |key| "flash-#{key}" }
    target.cattr_accessor :flash_message_tag
    target.flash_message_tag     = :div
    target.send :include, InstanceMethods
  end

  module InstanceMethods
    def flash_messages(options = {})
      ret = []
      flash.each do |key, value|
        ret << content_tag(ActionView::Base.flash_message_tag, value, {
            :class => ActionView::Base.flash_message_class_proc.call(key),
            :id    => ActionView::Base.flash_message_id_proc.call(key)
          }.merge(options)
        )
      end
      return ret.join("\n")
    end
  end

end
