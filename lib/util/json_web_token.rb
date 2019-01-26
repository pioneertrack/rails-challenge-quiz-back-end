module Util
  class JsonWebToken
    class << self
      def encode(user, user_agent)
        # TODO: use the user id and
        # the user agent to generate
        # a token with the JWT gem
        #
        # EXAMPLE
        # {
        #   user_id: user.id,
        #   user_agent: user_agent
        # }
      end

      def decode(token)
        # TODO: decode the token using the
        # JWT gem and return it with
        # symbolized keys
      rescue
        #  or nil if it is invalid
        # and raises
      end
    end
  end
end
