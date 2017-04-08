require 'roda'

module WebBouncer
  class Middleware < Roda
    plugin :middleware

    route do |r|
      r.is 'auth/failure' do
        OauthContainer['oauth.failure']
      end

      r.is 'auth/logout' do
        OauthContainer['oauth.logout']
      end

      r.on 'auth/:provider/callback' do |provider|
        action = OauthContainer["oauth.#{provider}_callback"] || OauthContainer["oauth.base_callback"]
        action.call
      end
    end
  end
end
