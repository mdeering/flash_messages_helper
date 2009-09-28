require File.dirname(__FILE__) + '/test_helper'

require 'flash_messages_helper'

ActionView::Base.send(:include, FlashMessagesHelper)

describe FlashMessagesHelper do

  view = ActionView::Base.new
  controller = ActionController::Base.new
  view.controller = controller

  it 'will have nothing to display of the flash is not set in any way' do
    controller.stub!(:flash).and_return({})
    view.flash_messages.should == ''
  end

  it 'will return a div with the error message' do
    controller.stub!(:flash).and_return({:error => 'There was an error'})
    view.flash_messages.should == "<div class=\"error\" id=\"flash-error\">There was an error</div>"
  end

  {
    :flash_message_class_proc => lambda { |key| "#{key}-message hiddable"},
    :flash_message_id_proc    => lambda { |key| "flash-#{key}-message"},
    :flash_message_tag        => :p
  }.each do |singleton_variable, value|
    it "should create flash_messages class (singleton) variable #{singleton_variable} on its included class" do
      ActionView::Base.send(singleton_variable).should_not == nil
      ActionView::Base.send("#{singleton_variable}=", value)
      ActionView::Base.send(singleton_variable).should == value
    end
  end

  # Now that the defaults have been set

  it 'will return a p with the error message and the defaults set differently' do
    controller.stub!(:flash).and_return({:error => 'There was an error'})
    view.flash_messages.should == "<p class=\"error-message hiddable\" id=\"flash-error-message\">There was an error</p>"
  end

  it 'will still honor the html options passed in' do
    controller.stub!(:flash).and_return({:error => 'There was an error'})
    view.flash_messages(:class => 'my-class').should == "<p class=\"my-class\" id=\"flash-error-message\">There was an error</p>"
  end

end
