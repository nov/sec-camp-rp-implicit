class SessionsController < ApplicationController
  def show
  end

  def new
    if params[:oauth]
      redirect_to current_client.authorization_uri(
        response_type: :token,
        scope: [:email, :profile]
      )
    else
      redirect_to current_client.authorization_uri(
        response_type: [:token, :id_token],
        scope: [:openid, :email, :profile]
      )
    end
  end

  def create
    access_token = current_client.tokenize params[:access_token]
    account = if params[:id_token].present?
      Account.authenticate_by_id_token params[:id_token], current_client.jwks
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
end
