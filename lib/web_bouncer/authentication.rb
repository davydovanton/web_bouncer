module WebBouncer
  module Authentication
    # def self.included(action)
    #   action.class_eval do
    #     expose :current_account
    #   end
    # end

  private

    def authenticate!
      redirect_to('/') unless authenticated?
    end

    def authenticated?
      !!current_account.id
    end

    def current_account
      @current_account ||= Account.new(session[:account])
    end
  end
end
