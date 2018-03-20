module WebBouncer
  class OauthCallback
    include Dry::Monads::Result::Mixin

    attr_reader :settings

    def initialize(settings)
      @settings = settings
    end

    def call(config)
      Success(true)
    end
  end
end
