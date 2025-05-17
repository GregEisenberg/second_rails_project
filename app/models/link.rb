class Link < ApplicationRecord
  belongs_to :user
  acts_as_votable
  has_many :comments

  validates :title, length: { minimum: 5 }
  validates :url, length: { minimum: 5 }
end
