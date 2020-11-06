class Course < ApplicationRecord
    has_many :course_registrations
    has_many :students, through: :course_registrations
    
    def date_to_s
        self.date.strftime("%B %d, %Y")
    end
end
