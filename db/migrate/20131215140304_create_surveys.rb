class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :ice_cream
      t.string :super_hero
      t.string :movie_star
      t.integer :world_end_year
      t.integer :world_end_month
      t.integer :world_end_day
      t.string :win_super_bowl

      t.timestamps
    end
  end
end
