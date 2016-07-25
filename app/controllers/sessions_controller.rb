class SessionsController < ApplicationController
  def show
  end

  def new
    redirect_to current_client.authorization_uri(
      response_type: [:token, :id_token],
      scope: [:openid, :email, :profile]
    )
  end

  def create
    access_token = current_client.tokenize params[:access_token]
    account = Account.authenticate params[:id_token]
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
