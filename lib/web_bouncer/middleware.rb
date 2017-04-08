require 'roda'

module WebBouncer
  class Middleware < Roda
    plugin :middleware

    route do |r|
      r.is 'auth/failure' do
        p OauthContainer['oauth.failure']
      end

      r.is 'auth/logout' do
        p OauthContainer['oauth.logout']
      end

      r.on 'auth/:provider/callback' do
        p OauthContainer['oauth.provider_callback']
      end
    end
  end
end
