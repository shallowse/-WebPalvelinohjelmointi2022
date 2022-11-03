module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    rating_count = ratings.size

    return 0 if rating_count == 0

    # ratings.average(:score).round(2)
    avg = ratings.map(&:score).sum.to_f / rating_count
    avg.round(2)
  end
end
