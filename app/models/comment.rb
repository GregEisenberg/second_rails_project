class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :link

  validates :body, length: { minimum: 10 }
end
