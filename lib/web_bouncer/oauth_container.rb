module WebBouncer
  class OauthContainer
    extend Dry::Container::Mixin

    configure do |config|
      config.registry = ->(container, key, item, options) { container[key] = item }
      config.resolver = ->(container, key) { container[key] }
    end

    register 'oauth.failure' do
      'oauth.failure'
    end

    register 'oauth.logout' do
      'oauth.logout'
    end

    register 'oauth.provider_callback' do
      'oauth.provider_callback'
    end
  end
end
