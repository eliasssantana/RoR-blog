class Post < ApplicationRecord
  belongs_to :user
  # has_many_or_belongs_to :posts_tags
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
end
