require 'roda'

module WebBouncer
  class Middleware < Roda
    DEFAULT_CONFIG = {
      model: :account,
      login_redirect: '/',
      logout_redirect: '/',
      failure_redirect: '/',
      login_failed_redirect: '/',
      allow_oauth: true
    }

    plugin :middleware do |middleware, config = {}, &block|
      config = DEFAULT_CONFIG.merge(config)

      middleware.opts[:config] = config
      block.call(middleware) if block
    end
  end
end
