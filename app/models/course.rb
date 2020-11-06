class Course < ApplicationRecord
    def date_to_s
        self.date.strftime("%B %d, %Y")
    end
end
