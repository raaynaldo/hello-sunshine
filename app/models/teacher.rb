class Teacher < ApplicationRecord
    has_secure_password
    belongs_to :company
    has_many :courses
end
