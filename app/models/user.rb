class User < ActiveRecord::Base
  after_save :save_in_mongodb

  attr_accessible :first_name, :last_name, :email, :birth_year, :birth_month, :birth_day, :shoe_size

  has_many :surveys

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true,
                         length:     {maximum: 254, message: "Email is too long."},
                         uniqueness: true,
                         format:     {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, message: "Invalid email."}

  validates :shoe_size, :birth_day, :birth_year, presence: true,
                                                 numericality: true

  private

  def save_in_mongodb 
    MongoUser.create self.attributes
  end
end

class MongoUser
  include MongoMapper::Document

  key :first_name,  String
  key :last_name,   String
  key :email,       String
  key :birth_year,  Integer
  key :birth_month, Integer
  key :birth_day,   Integer
  key :shoe_size,   Integer
end

