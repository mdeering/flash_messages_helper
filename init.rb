require File.dirname(__FILE__) + '/lib/flash_messages_helper'
ActionView::Base.send(:include, FlashMessagesHelper)
