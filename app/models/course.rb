class Course < ApplicationRecord
    has_many :course_registrations
    has_many :students, through: :course_registrations
end
