class CompanyAdmin < ApplicationRecord
    has_secure_password
    belongs_to :company
    accepts_nested_attributes_for :company

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
end
