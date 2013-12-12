class UpdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_year, :integer
    add_column :users, :birth_month, :integer
  end
end