class User < ApplicationRecord
    has_many :users_accounts
    has_many :accounts, through: :users_accounts, dependent: :destroy
    has_many :users_bills
    has_many :bills, through: :users_bills, dependent: :destroy
    
    has_secure_password

    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.name = auth.info.name
        #   user.oauth_token = auth.credentials.token
        #   user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          user.save!
        end
    end
end