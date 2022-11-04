class Style < ApplicationRecord
  extend TopRating

  has_many :beers

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def to_s
    name.to_s
  end
end
