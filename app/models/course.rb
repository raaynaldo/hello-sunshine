class Course < ApplicationRecord
    has_many :course_registrations
    has_many :students, through: :course_registrations
    belongs_to :teacher
    
    validates :title, presence: true
    validates :price, presence: true
    validates :min_age, numericality: {greater_than: -1, less_than_or_equal_to: :max_age }, presence: true
    validates :max_age, numericality: {less_than_or_equal_to: 14 }, presence: true
    validates :max_student, numericality: {less_than_or_equal_to: 15}

    def date_to_s
        self.date.strftime("%B %d, %Y")
    end
end
