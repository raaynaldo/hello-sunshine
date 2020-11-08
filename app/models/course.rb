class Course < ApplicationRecord
    has_many :course_registrations
    has_many :students, through: :course_registrations
    belongs_to :teacher
    
    def date_to_s
        self.date.strftime("%B %d, %Y")
    end
end
