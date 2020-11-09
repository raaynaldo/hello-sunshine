class Student < ApplicationRecord
    has_secure_password
    has_many :course_registrations
    has_many :courses, through: :course_registrations
end
