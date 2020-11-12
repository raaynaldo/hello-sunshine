class Company < ApplicationRecord
  has_many :teachers
  has_many :company_admins

  validates :name, presence: true, uniqueness: true

  def courses
    courses_arr = []
    self.teachers.each{ |teacher|
        courses_arr = courses_arr + teacher.courses
    }
    courses_arr
  end

  def previous_courses
    courses_arr = []
    self.teachers.each{ |teacher|
        courses_arr = courses_arr + teacher.previous_courses
    }
    courses_arr
  end

  def incoming_courses
    courses_arr = []
    self.teachers.each{ |teacher|
        courses_arr = courses_arr + teacher.incoming_courses
    }
    courses_arr
  end
end
