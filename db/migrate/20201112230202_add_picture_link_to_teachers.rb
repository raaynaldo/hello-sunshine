class AddPictureLinkToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :picture_link, :string
  end
end
