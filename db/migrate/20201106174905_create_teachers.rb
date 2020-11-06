class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.integer :company_id
      t.string :specialty
      t.string :hobbies
      t.string :website_link
      t.string :email
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
