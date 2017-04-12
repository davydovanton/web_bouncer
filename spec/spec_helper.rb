require 'bundler/setup'
Bundler.setup

require 'web_bouncer'
require 'rack/test'
require 'dry-monads'

ENV['RACK_ENV'] = 'test'

class TestingApp < Roda
  use Rack::Session::Cookie, secret: '123'

  use WebBouncer::OauthMiddleware, {
    model: :account,
    login_redirect: '/',
    logout_redirect: '/'
  }

  route {}
end

module RSpecMixin
  include Rack::Test::Methods
  def app() TestingApp end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = false

  config.order = :random
end
