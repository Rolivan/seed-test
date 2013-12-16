class Survey < ActiveRecord::Base
  after_save :save_in_mongodb

  attr_accessible :ice_cream, :movie_star, :super_hero, :win_super_bowl, :world_end_day, :world_end_month, :world_end_year

  belongs_to :user

  validates :ice_cream, :movie_star, :super_hero, :win_super_bowl, :world_end_day, :world_end_month, :world_end_year, presence: true
  validates :win_super_bowl, :world_end_day, :world_end_year, numericality: { :only_integer => true }

  private

  def save_in_mongodb 
    MongoSurvey.create self.attributes
  end
end

class MongoSurvey
  include MongoMapper::Document

  key :ice_cream,       String
  key :movie_star,      String
  key :super_hero,      String
  key :win_super_bowl,  String
  key :world_end_year,  Integer
  key :world_end_day,   Integer
  key :world_end_month, Integer
end

