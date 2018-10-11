# frozen_string_literal: true

require 'spec_helper'

require 'action_view'
require 'action_controller'

require 'flash_messages_helper'

describe FlashMessagesHelper do

  let(:controller) { ActionController::Base.new }
  let(:view)       { ActionView::Base.new }

  before do
    view.controller = controller
    described_class.instance_variable_set('@configuration', FlashMessagesHelper::Configuration.new)
  end

  it 'will have nothing to display of the flash is not set in any way' do
    allow(controller).to receive(:flash).and_return({})
    expect(view.flash_messages).to eq('')
  end

  it 'will return a div with the error message' do
    allow(controller).to receive(:flash).and_return(error: 'There was an error')
    expect(view.flash_messages).to eq '<div class="error" id="flash-error">There was an error</div>'
  end

  # Now that the defaults have been set

  it 'will return a p with the error message and the defaults set differently' do
    described_class.configuration.wrapper = :p
    allow(controller).to receive(:flash).and_return(error: 'There was an error')
    expect(view.flash_messages).to eq '<p class="error" id="flash-error">There was an error</p>'
  end

  it 'will still honor the html options passed in' do
    allow(controller).to receive(:flash).and_return(error: 'There was an error')
    expect(view.flash_messages(class: 'my-class', role: :alert))
      .to eq '<div class="my-class" id="flash-error" role="alert">There was an error</div>'
  end

end
