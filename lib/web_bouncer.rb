require "web_bouncer/oauth_container"
require "web_bouncer/middleware"
require "web_bouncer/version"
require "dry/matcher/either_matcher"

module WebBouncer
  Matcher = Dry::Matcher::EitherMatcher
end
