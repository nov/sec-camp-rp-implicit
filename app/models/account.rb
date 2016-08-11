class Account < ApplicationRecord
  def import!(userinfo)
    self.name = userinfo.name
    self.email = userinfo.email
    self.save!
  end

  class << self
    def authenticate_by_id_token(id_token_str, jwks)
      id_token = JSON::JWT.decode id_token_str, jwks
      find_or_initialize_by(identifier: id_token[:sub])
    end

    def authenticate_by_access_token(access_token)
      userinfo = access_token.userinfo!
      find_or_initialize_by(identifier: userinfo.sub)
    end
  end
end
