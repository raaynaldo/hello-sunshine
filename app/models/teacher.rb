class Teacher < ApplicationRecord
    has_secure_password
    belongs_to :company
    has_many :courses

    validates :email, presence: true, uniqueness: true
end
