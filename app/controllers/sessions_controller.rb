class SessionsController < ApplicationController
  before_action :validate_state!, only: :create

  def show
  end

  def new
    if params[:oauth]
      redirect_to current_client.authorization_uri(
        response_type: :token,
        scope: [:email, :profile],
        state: (session[:state] = SecureRandom.hex(16))
      )
    else
      redirect_to current_client.authorization_uri(
        response_type: [:token, :id_token],
        scope: [:openid, :email, :profile],
        state: (session[:state] = SecureRandom.hex(16)),
        nonce: (session[:nonce] = SecureRandom.hex(16))
      )
    end
  end

  def create
    raise params[:error] if params[:error].present?
    access_token = current_client.tokenize params[:access_token]
    account = if params[:id_token].present?
      Account.authenticate_by_id_token params[:id_token], current_client, session.delete(:nonce)
    else
      Account.authenticate_by_access_token access_token
    end
    account.import! access_token.userinfo! if account.new_record?
    authenticate account
    redirect_to root_url
  end

  def destroy
    unauthenticate!
    redirect_to root_url
  end

  private

  def current_client
    @client ||= Client.first
  end

  def validate_state!
    unless session.delete(:state) == params[:state]
      raise 'CSRF Attack Detected'
    end
  end
end
