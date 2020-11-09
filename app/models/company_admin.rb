class CompanyAdmin < ApplicationRecord
    has_secure_password
    belongs_to :company
    accepts_nested_attributes_for :company
end
