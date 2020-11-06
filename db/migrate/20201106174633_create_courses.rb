class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :course_type
      t.datetime :date
      t.float :price
      t.integer :min_age
      t.integer :max_age
      t.integer :max_student
      t.string :location
      t.string :picture
      t.integer :teacher_id

      t.timestamps
    end
  end
end
