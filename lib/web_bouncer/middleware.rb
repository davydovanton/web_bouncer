require 'roda'

module WebBouncer
  class Middleware < Roda
    plugin :middleware

    route do |r|
      r.is 'auth/failure' do
        Matcher.call(OauthContainer['oauth.failure'].call) do |m|
          m.success do |v|
            "Successed #{v}"
          end

          m.failure do |v|
            "Failed #{v}"
          end
        end
      end

      r.is 'auth/logout' do
        Matcher.call(OauthContainer['oauth.logout'].call) do |m|
          m.success do |value|
            env[:account] = value
          end

          m.failure do |v|
          end
        end

        r.redirect "/"
      end

      r.on 'auth/:provider/callback' do |provider|
        action = OauthContainer["oauth.#{provider}_callback"] || OauthContainer["oauth.base_callback"]

        Matcher.call(action.call) do |m|
          m.success do |value|
            env[:account] = value
          end

          m.failure do |v|
          end
        end

        r.redirect "/"
      end
    end
  end
end
