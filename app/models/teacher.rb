class Teacher < ApplicationRecord
    # has_secure_password
    belongs_to :company
    has_many :courses, :dependent => :restrict_with_error

    validates :name, presence: true

    def self.find_by_company(company_id)
        Teacher.where(company_id: company_id)
    end

    def incoming_courses
        self.courses.where("date(date) >= date('now')")
    end

    def previous_courses
        self.courses.where("date(date) < date('now')")
    end
end
