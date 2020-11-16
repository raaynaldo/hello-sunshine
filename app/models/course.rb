class Course < ApplicationRecord
    has_many :course_registrations, :dependent => :destroy
    has_many :students, through: :course_registrations
    belongs_to :teacher
    has_one_attached :picture
    
    validates :title, presence: true
    validates :price, presence: true
    validates :min_age, numericality: {greater_than: -1, less_than_or_equal_to: :max_age }, presence: true
    validates :max_age, numericality: {greater_than: :min_age, less_than_or_equal_to: 14 }, presence: true
    validates :max_student, numericality: {less_than_or_equal_to: 15}

    # def initialize(*args)
    #     super
    #     self.date = DateTime.now
    # end

    def date_to_s
        self.date.strftime("%B %d, %Y")
    end

    def company
        self.teacher.company
    end

    def self.incoming_courses
        self.where("date(date) >= date('now')")
    end
end
