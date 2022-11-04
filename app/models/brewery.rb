class Brewery < ApplicationRecord
  include ActiveModel::Validations
  include RatingAverage
  extend TopRating

  validates :name, presence: true
  validate :prohibited_year_range

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def print_report
    puts name
    puts "establised at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end

  def prohibited_year_range
    # 1. check that year contains an integer value
    # 2. check that year >= 1040
    # 3. check that year is <= current year

    # Inspiration from https://stackoverflow.com/a/9075606
    # Pattern dddd, where the first digit is a non-zero value
    errors.add(:year, "must be an integer value") unless year =~ /^[1-9][0-9]{3}$/

    errors.add(:year, "must be greater than 1040 ") if year.to_i < 1040

    errors.add(:year, "must be less than #{Time.now.year}") if year.to_i > Time.now.year
  end
end
