class Rating < ApplicationRecord
  belongs_to :beer

  def to_s
    score
  end
end
