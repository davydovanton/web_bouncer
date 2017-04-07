require 'roda'

module WebBouncer
  class Middleware < Roda
    plugin :middleware

    route do |r|
      r.is 'auth/failure' do
        p 'auth/failure'
      end

      r.is 'auth/logout' do
        p 'auth/logout'
      end

      r.on 'auth/:provider' do
        p 'auth/:provider'
      end
    end
  end
end
