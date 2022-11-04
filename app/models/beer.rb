class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  belongs_to :style, touch: true

  validates :name, presence: true
  # validates :style_id, presence: true

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
    name.to_s
  end

  # vk7/tehtävä13: ks. kommentti app/models/concers/top_rating.rb
  def self.top(num)
    return [] unless num > 0

    top_sorted = Beer.all.sort_by { |a| -a.average_rating }
    top_sorted[0...num]
  end
end
