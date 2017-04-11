require 'dry-monads'
require 'dry-container'

module WebBouncer
  class OauthContainer
    extend Dry::Container::Mixin
    extend Dry::Monads::Either::Mixin

    configure do |config|
      config.registry = ->(container, key, item, options) { container[key] = item }

      config.resolver = ->(container, key) do
        case container[key]
        when Class
          ->(settings, data) { container[key].new(settings).call(data) }
        else
          container[key]
        end
      end
    end

    register 'oauth.failure' do |config, _data|
      Right(nil)
    end

    register 'oauth.logout' do |config, _data|
      Right(nil)
    end

    register 'oauth.base_callback' do |data, config|
      Right('account object')
    end
  end
end
