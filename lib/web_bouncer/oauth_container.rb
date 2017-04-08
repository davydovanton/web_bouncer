require 'dry-monads'

module WebBouncer
  class OauthContainer
    extend Dry::Container::Mixin
    extend Dry::Monads::Either::Mixin

    configure do |config|
      config.registry = ->(container, key, item, options) { container[key] = item }
      config.resolver = ->(container, key) { container[key] }
    end

    register 'oauth.failure' do
      Right('oauth.failure')
    end

    register 'oauth.logout' do
      Right('oauth.logout')
    end

    register 'oauth.base_callback' do
      Right('oauth.base_callback')
    end
  end
end
