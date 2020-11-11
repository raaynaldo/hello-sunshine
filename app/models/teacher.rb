class Teacher < ApplicationRecord
    has_secure_password
    belongs_to :company
    has_many :courses

    validates :email, presence: true, uniqueness: true

    def self.find_by_company(company_id)
        Teacher.where(company_id: company_id)
    end
end
