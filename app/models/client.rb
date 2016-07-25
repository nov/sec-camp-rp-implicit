class Client < ApplicationRecord
  delegate :authorization_uri, to: :connect_client

  def tokenize(access_token)
    OpenIDConnect::AccessToken.new(
      access_token: access_token,
      client: connect_client
    )
  end

  private

  def connect_client
    @connect_client ||= OpenIDConnect::Client.new(
      identifier: identifier,
      secret: secret,
      redirect_uri: redirect_uri,
      authorization_endpoint: authorization_endpoint,
      token_endpoint: token_endpoint,
      userinfo_endpoint: userinfo_endpoint
    )
  end
end
