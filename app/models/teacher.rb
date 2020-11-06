class Teacher < ApplicationRecord
    belongs_to :company
    has_many :courses
end
