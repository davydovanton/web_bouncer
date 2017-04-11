require 'dry-monads'
require 'dry-container'

module WebBouncer
  class OauthContainer
    extend Dry::Container::Mixin
    extend Dry::Monads::Either::Mixin

    configure do |config|
      config.registry = ->(container, key, item, options) do
        container[key] = item.is_a?(Class) ? item.new : item
      end

      config.resolver = ->(container, key) { container[key] }
    end

    register 'oauth.failure' do |config|
      Right(nil)
    end

    register 'oauth.logout' do |config|
      Right(nil)
    end

    register 'oauth.base_callback' do |data, config|
      Right('account object')
    end
  end
end
