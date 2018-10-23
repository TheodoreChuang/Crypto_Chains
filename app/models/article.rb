class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable

  # has_many :votes, dependent: :destroy
  # has_many :article_tags, dependent: :destroy
  # has_many :tags, through: :article_tags #, dependent: :destroy

  attribute :views, :integer, default: -1
end
