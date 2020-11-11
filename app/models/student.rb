class Student < ApplicationRecord
    has_secure_password
    has_many :course_registrations
    has_many :courses, through: :course_registrations

    validates :name, presence: true
    validates :email, :username, presence: true, uniqueness: true

    def incoming_courses
        self.courses.where("date(date) >= date('now')")
    end

    def previous_courses
        self.courses.where("date(date) < date('now')")
    end
end
