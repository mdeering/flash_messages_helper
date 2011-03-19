require File.dirname(__FILE__) + '/test_helper'

require 'flash_messages_helper'

ActionView::Base.send(:include, FlashMessagesHelper)

describe FlashMessagesHelper do

  before do
    @view = ActionView::Base.new
    @controller = ActionController::Base.new
    @view.controller = @controller
    FlashMessagesHelper.configuration = FlashMessagesHelper::Configuration.new
  end

  it 'will have nothing to display of the flash is not set in any way' do
    @controller.stub!(:flash).and_return({})
    @view.flash_messages.should == ''
  end

  it 'will return a div with the error message' do
    @controller.stub!(:flash).and_return({ :error => 'There was an error' })
    @view.flash_messages.should == "<div class=\"error\" id=\"flash-error\">There was an error</div>"
  end

  {
    :flash_message_class_proc => lambda { |key| "#{key}-message hiddable" },
    :flash_message_id_proc    => lambda { |key| "flash-#{key}-message" },
    :flash_message_tag        => :p
  }.each do |singleton_variable, value|
    it "should give deprication warnings for 0.1.0 usage but still set configuration points" do
      ActiveSupport::Deprecation.should_receive(:warn)
      ActionView::Base.send("#{singleton_variable}=", value)
      FlashMessagesHelper.configuration.css_class == value if singleton_variable == :flash_message_class_proc
      FlashMessagesHelper.configuration.dom_id    == value if singleton_variable == :flash_message_id_proc
      FlashMessagesHelper.configuration.wrapper   == value if singleton_variable == :flash_message_tag
    end
  end

  # Now that the defaults have been set

  it 'will return a p with the error message and the defaults set differently' do
    FlashMessagesHelper.configuration.wrapper = :p
    @controller.stub!(:flash).and_return({ :error => 'There was an error' })
    @view.flash_messages.should == "<p class=\"error\" id=\"flash-error\">There was an error</p>"
  end

  it 'will still honor the html options passed in' do
    @controller.stub!(:flash).and_return({ :error => 'There was an error' })
    @view.flash_messages(:class => 'my-class').should == "<div class=\"my-class\" id=\"flash-error\">There was an error</div>"
  end

  it 'will call html_safe on the return string if available'

end
