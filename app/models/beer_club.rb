class BeerClub < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  def confirmed_members
    memberships.where(confirmed: true)
  end

  def not_confirmed_members
    memberships.where(confirmed: [nil, false])
  end

  def to_s
    name.to_s
  end
end
