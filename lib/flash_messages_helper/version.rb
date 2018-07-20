# frozen_string_literal: true

module FlashMessagesHelper

  class Version

    MAJOR       = 1
    MINOR       = 0
    PATCH       = 0
    PRE_RELEASE = 'alpha1'.freeze

    def self.to_s
      [MAJOR, MINOR, PATCH, PRE_RELEASE].compact.join('.')
    end

  end

end
