# frozen_string_literal: true

module Nfeiow
  module Helpers
    RequestResut = Struct.new(:success?, :error, :value)

    def headers
      {
        "Content-Type": 'application/json',
        'Accept': 'application/json',
        'Authorization': api_key
      }
    end

    def result(success, error, value)
      RequestResut.new(success, error, value)
    end
  end
end
