module Requests
  module JsonHelpers
    def json
      #   puts last_response.body
      JSON.parse(last_response.body)
    end
  end
end
