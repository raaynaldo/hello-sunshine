class AddPictureLinkToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :picture_link, :string
  end
end
