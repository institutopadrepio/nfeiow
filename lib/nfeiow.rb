# frozen_string_literal: true

require_relative 'nfeiow/version'
require_relative 'nfeiow/client'
require_relative 'nfeiow/configuration'

module Nfeiow
  class ClientConfiguration
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
