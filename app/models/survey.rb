class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :choices, through: :questions #added this
  validates_presence_of :title

  # Remember to create a migration!


end
