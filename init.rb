require File.dirname(__FILE__) + '/lib/flash_helper'

ActionView::Base.send(:include, FlashHelper)
