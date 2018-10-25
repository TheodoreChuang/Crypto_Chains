class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  # for votes
  acts_as_votable
  has_many :articles_tags
  has_many :tags, through: :articles_tags, dependent: :destroy

  # sets a default value
  attribute :views, :integer, default: -1

  # saving tags upon article new or edit
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  # tags into a string
  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name(name).articles
  end
end
