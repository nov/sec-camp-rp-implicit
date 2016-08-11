class Client < ApplicationRecord
  delegate :authorization_uri, to: :connect_client

  def tokenize(access_token)
    OpenIDConnect::AccessToken.new(
      access_token: access_token,
      client: connect_client
    )
  end

  def jwks
    config.jwks
  end

  private

  def config
    @config ||= OpenIDConnect::Discovery::Provider::Config.discover! issuer
  end

  def connect_client
    @connect_client ||= OpenIDConnect::Client.new(
      identifier: identifier,
      secret: secret,
      redirect_uri: redirect_uri,
      authorization_endpoint: config.authorization_endpoint,
      token_endpoint: config.token_endpoint,
      userinfo_endpoint: config.userinfo_endpoint
    )
  end
end
