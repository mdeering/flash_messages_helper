# frozen_string_literal: true

require 'spec_helper'

require 'action_view'
require 'action_controller'

require 'flash_messages_helper'

describe FlashMessagesHelper do

  before do
    @view = ActionView::Base.new
    @controller = ActionController::Base.new
    @view.controller = @controller
    FlashMessagesHelper.instance_variable_set('@configuration', FlashMessagesHelper::Configuration.new)
  end

  it 'will have nothing to display of the flash is not set in any way' do
    @controller.stub(:flash).and_return({})
    @view.flash_messages.should == ''
  end

  it 'will return a div with the error message' do
    @controller.stub(:flash).and_return(error: 'There was an error')
    @view.flash_messages.should == '<div class="error" id="flash-error">There was an error</div>'
  end

  # Now that the defaults have been set

  it 'will return a p with the error message and the defaults set differently' do
    FlashMessagesHelper.configuration.wrapper = :p
    @controller.stub(:flash).and_return(error: 'There was an error')
    @view.flash_messages.should == '<p class="error" id="flash-error">There was an error</p>'
  end

  it 'will still honor the html options passed in' do
    @controller.stub(:flash).and_return(error: 'There was an error')
    @view.flash_messages(class: 'my-class', role: :alert).should == '<div class="my-class" id="flash-error" role="alert">There was an error</div>'
  end

end
