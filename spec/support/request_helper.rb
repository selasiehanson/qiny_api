module Requests
  module JsonHelpers
    def json
      # puts last_response.body
      JSON.parse(last_response.body)
    end
  end

  module AuthHelpers
    def valid_auth(user_id)
      Knock::AuthToken.new(payload: { sub: user_id }).token
    end

    def auth_header(token)
      { 'HTTP_AUTHORIZATION' => "Bearer #{token}" }
    end
  end
end
