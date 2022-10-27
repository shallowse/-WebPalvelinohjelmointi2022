class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4 },
                       format: { with: /.*([A-Z].*\d|\d.*[A-Z])+.*/,
                                 message: 'At least one capital letter and one number' }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    avg = average_rating
    over_avg = ratings.select { |rating| rating.score >= avg }
    over_avg.map { |k| k.beer.style }.uniq
  end

  def favorite_brewery
    avg = average_rating
    over_avg = ratings.select { |rating| rating.score >= avg }
    over_avg.map { |k| k.beer.brewery }.uniq
  end
end
