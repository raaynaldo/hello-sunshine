class Company < ApplicationRecord
    has_many :teachers
    has_many :company_admins
end
