class Account < ApplicationRecord
  def import!(userinfo)
    self.name = userinfo.name
    self.email = userinfo.email
    self.save!
  end

  class << self
    def authenticate_by_id_token(id_token_str, client, nonce)
      id_token = JSON::JWT.decode id_token_str, client.jwks
      unless (
        id_token[:iss] == client.issuer &&
        id_token[:aud] == client.identifier &&
        id_token[:nonce] == nonce &&
        Time.at(id_token[:exp]) >= Time.now
      )
        raise 'Invalid ID Token'
      end
      find_or_initialize_by(identifier: id_token[:sub])
    end

    def authenticate_by_access_token(access_token, client)
      userinfo = access_token.userinfo!
      # token_metadata = JSON.parse(
      #   access_token.get(
      #     File.join(client.issuer, 'token_introspection')
      #   ).body
      # ).with_indifferent_access
      # logger.info token_metadata
      # unless token_metadata[:aud] == client.identifier
      #   raise 'Invalid Access Token Audience'
      # end
      find_or_initialize_by(identifier: userinfo.raw_attributes[:id])
    end
  end
end
