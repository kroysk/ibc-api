class ContactRequest < ApplicationRecord
    validates :name, presence: true
    validates :cellphone, presence: true, unless: -> { email.present? }
    validates :email, presence: true, unless: -> { cellphone.present? }
end
