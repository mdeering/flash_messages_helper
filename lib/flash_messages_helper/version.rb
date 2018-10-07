# frozen_string_literal: true

module FlashMessagesHelper

  # Utility module for semantic versioning the gem
  module Version

    MAJOR       = 1
    MINOR       = 0
    PATCH       = 0
    PRE_RELEASE = 'alpha1'.freeze

    # Current semantic version of the gem
    #
    # @example
    #   s.version = FlashMessagesHelper::Version
    #
    # @return [String]
    def self.to_s
      [MAJOR, MINOR, PATCH, PRE_RELEASE].compact.join('.')
    end

  end

end
