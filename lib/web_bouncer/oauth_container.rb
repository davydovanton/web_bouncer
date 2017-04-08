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
      Right(nil)
    end

    register 'oauth.logout' do
      Right(nil)
    end

    register 'oauth.base_callback' do
      Right('account object')
    end
  end
end
