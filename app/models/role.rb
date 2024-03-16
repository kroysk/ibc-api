class Role < ApplicationRecord
    has_many :role_permissions
    has_many :permissions, through: :role_permissions
   
    validates :code, presence: true, uniqueness: true
end
