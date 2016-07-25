class Account < ApplicationRecord
  def import!(userinfo)
    self.name = userinfo.name
    self.email = userinfo.email
    self.save!
  end

  class << self
    def authenticate(id_token_str)
      id_token = JSON::JWT.decode id_token_str, :skip_verification
      find_or_initialize_by(identifier: id_token[:sub])
    end
  end
end
