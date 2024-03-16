class User < ApplicationRecord
    # has_and_belongs_to_many :roles
    has_many :user_roles
    has_many :roles, through: :user_roles
    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
                length: { minimum: 6 },
                if: -> { new_record? || !password.nil? }
end
