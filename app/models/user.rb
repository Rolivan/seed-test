class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :birth_year, :birth_month, :birth_day, :shoe_size

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true,
                         length:     {maximum: 254, message: "Email is too long."},
                         uniqueness: true,
                         format:     {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, message: "Invalid email."}

  validates :shoe_size, :birth_day, :birth_year, presence: true,
                                                 numericality: true
end
