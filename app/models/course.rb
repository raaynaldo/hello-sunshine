class Course < ApplicationRecord
    has_many :course_registrations
    has_many :students, through: :course_registrations
    belongs_to :teacher
    
    validates :title, presence: true
    # validates :
    def date_to_s
        self.date.strftime("%B %d, %Y")
    end
end
