class Account < ApplicationRecord
  def import!(userinfo)
    self.name = userinfo.name
    self.email = userinfo.email
    self.save!
  end

  class << self
    def authenticate_by_id_token(id_token_str, client, nonce)
      id_token = JSON::JWT.decode id_token_str, client.jwks
      if (
        id_token[:iss] == client.issuer &&
        id_token[:aud] == client.identifier &&
        id_token[:nonce] == nonce &&
        Time.at(id_token[:exp]) >= Time.now
      )
        find_or_initialize_by(identifier: id_token[:sub])
      else
        raise 'ID Token Invalid'
      end
    end

    def authenticate_by_access_token(access_token)
      userinfo = access_token.userinfo!
      find_or_initialize_by(identifier: userinfo.sub)
    end
  end
end
