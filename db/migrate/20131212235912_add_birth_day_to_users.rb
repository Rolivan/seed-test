class AddBirthDayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_day, :integer
  end
end
