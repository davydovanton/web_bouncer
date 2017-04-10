require "web_bouncer/oauth_container"
require "web_bouncer/authentication"
require "web_bouncer/middleware"
require "web_bouncer/version"

require "dry/matcher/either_matcher"
require 'dry-container'

module WebBouncer
  Matcher = Dry::Matcher::EitherMatcher

  class Container
    extend ::Dry::Container::Mixin

    register 'middleware', WebBouncer::Middleware
    register 'authentication', WebBouncer::Authentication
  end
end
