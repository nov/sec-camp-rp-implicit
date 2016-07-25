module Concerns
  module Authentication
    def self.included(klass)
      klass.send :helper_method, :current_account, :authenticated?
      klass.send :before_action, :optional_authentication
    end

    def authenticated?
      !current_account.blank?
    end

    def current_account
      @current_account
    end

    def optional_authentication
      if session[:current_account]
        authenticate Account.find_by_id(session[:current_account])
      end
    rescue ActiveRecord::RecordNotFound
      unauthenticate!
    end

    def authenticate(account)
      if account
        @current_account = account
        session[:current_account] = account.id
      end
    end

    def unauthenticate!
      @current_account = session[:current_account] = nil
    end
  end
end