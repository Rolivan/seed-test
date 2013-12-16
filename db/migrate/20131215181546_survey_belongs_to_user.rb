class SurveyBelongsToUser < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.references :user
    end
  end
end
