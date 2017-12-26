require "web_bouncer/middleware"

module WebBouncer
  class OauthMiddleware < Middleware
    route do |r|
      config = opts[:config]

      r.is 'auth/failure' do
        Matcher.call(OauthContainer['oauth.failure'].call(config, {})) do |m|
          m.success {}
          m.failure {}
        end

        r.redirect config[:failure_redirect]
      end

      r.is 'auth/logout' do
        Matcher.call(OauthContainer['oauth.logout'].call(config, {})) do |m|
          m.success do |value|
            session[config[:model]] = value
          end

          m.failure {}
        end

        r.redirect config[:logout_redirect]
      end

      r.on 'auth', String, 'callback' do |provider|
        action = OauthContainer["oauth.#{provider}_callback"] || OauthContainer["oauth.base_callback"]
        data = request.env['omniauth.auth']

        Matcher.call(action.call(config, data)) do |m|
          m.success do |value|
            session[config[:model]] = value
          end

          m.failure {
            r.redirect config[:login_failed_redirect]
          }
        end

        r.redirect config[:login_redirect]
      end
    end
  end
end
