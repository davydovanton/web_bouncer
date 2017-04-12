module WebBouncer
  class OauthCallback
    include Dry::Monads::Either::Mixin

    attr_reader :settings

    def initialize(settings)
      @settings = settings
    end

    def call(config)
      Right(true)
    end
  end
end
