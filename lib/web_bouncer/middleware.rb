require 'roda'

module WebBouncer
  class Middleware < Roda
    DEFAULT_CONFIG = {
      model: :account,
      login_redirect: '/',
      logout_redirect: '/',
      failure_redirect: '/',
      allow_oauth: true
    }

    plugin :middleware do |middleware, config = {}, &block|
      config = DEFAULT_CONFIG.merge(config)

      middleware.opts[:config] = config
      block.call(middleware) if block
    end

    route do |r|
      config = opts[:config]

      if config[:allow_oauth]
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

        r.on 'auth/:provider/callback' do |provider|
          action = OauthContainer["oauth.#{provider}_callback"] || OauthContainer["oauth.base_callback"]
          data = request.env['omniauth.auth']

          Matcher.call(action.call(config, data)) do |m|
            m.success do |value|
              session[config[:model]] = value
            end

            m.failure {}
          end

          r.redirect config[:login_redirect]
        end
      end
    end

  end
end
