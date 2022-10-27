class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  # def average_rating
  #  # Viikko 2, Tehtävä 4
  #  ratings.average(:score).round(2)
  #
  #  # Viikko 2, Tehtävä 5
  #  # scores = ratings.map { |rating| rating.score }
  #  # sum = scores.reduce(:+)
  #  # average = sum.to_f / scores.length
  #  # average.round(2)
  # end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{name}: #{brewery.name}"
  end
end
