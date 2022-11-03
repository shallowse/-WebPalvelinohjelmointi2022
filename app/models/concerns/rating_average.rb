module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    rating_count = ratings.size

    return 0 if rating_count == 0

    # ratings.average(:score).round(2)
    ratings.map(&:score).sum.to_f / rating_count
  end
end
