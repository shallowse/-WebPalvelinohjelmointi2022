class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  #def average_rating
  #  # Viikko 2, Tehtävä 4
  #  ratings.average(:score).round(2)
  #
  #  # Viikko 2, Tehtävä 5
  #  # scores = ratings.map { |rating| rating.score }
  #  # sum = scores.reduce(:+)
  #  # average = sum.to_f / scores.length
  #  # average.round(2)
  #end

  def to_s
    "#{name}: #{brewery.name}"
  end
end
