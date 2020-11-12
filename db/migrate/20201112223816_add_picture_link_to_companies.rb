class AddPictureLinkToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :picture_link, :string
  end
end
