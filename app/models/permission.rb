class Permission < ApplicationRecord
    has_many :role_permissions
    validates :resource, presence: true, uniqueness: true
end
