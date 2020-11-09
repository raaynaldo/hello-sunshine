class Company < ApplicationRecord
    has_many :teachers
    has_many :company_admins

    validates :email, presence: true, uniqueness: true
end
