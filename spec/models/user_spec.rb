require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the usename set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    # expect(user.valid?).to be(false)
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a too short username" do
    user = User.create username: "Pekka", password: "s", password_confirmation: "s"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with username containing only lowercase letters" do
    user = User.create username: "Pekka", password: "secret1", password_confirmation: "secret1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved with a proper password" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, had the correct average rating" do
      style = FactoryBot.create(:style, name: 'Lager100')
      beer = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, score: 10, user: user, beer: beer)

      style = FactoryBot.create(:style, name: 'Lager101')
      beer = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, score: 20, user: user, beer: beer)
     
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "withouth ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      style = FactoryBot.create(:style, name: 'Lager200')
      beer = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, score: 7, user: user, beer: beer)

      style = FactoryBot.create(:style, name: 'Lager201')
      beer = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, score: 10, user: user, beer: beer)


      style = FactoryBot.create(:style, name: 'Lager202')
      best = FactoryBot.create(:beer, style: style)
      FactoryBot.create(:rating, score: 25, user: user, beer: best)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user) { FactoryBot.create(:user) }

    it "has method for detemining one" do
      beer = create_beer_with_rating({ user: user }, 10)

      expect(user.favorite_style.first).to eq(beer.style.name)
    end

    it "can list multiple favorite styles that are over the average rating" do
      style = FactoryBot.create(:style, name: 'Lager1')
      create_beer_with_rating_style({ user: user }, 10, { style: style })

      style = FactoryBot.create(:style, name: 'Lager2')
      create_beer_with_rating_style({ user: user }, 12, { style: style })

      style = FactoryBot.create(:style, name: 'Lager3')
      create_beer_with_rating_style({ user: user }, 10, { style: style })

      style = FactoryBot.create(:style, name: 'Lager4')
      create_beer_with_rating_style({ user: user }, 10, { style: style })

      style = FactoryBot.create(:style, name: 'Lager5')
      create_beer_with_rating_style({ user: user }, 12, { style: style })

      expect(user.favorite_style).to eq(["Lager2", "Lager5"])
    end
  end

  describe "favorite brewerie" do
    let(:user) { FactoryBot.create(:user) }

    it "has method for detemining one" do
      beer = create_beer_with_rating({ user: user }, 10)

      expect(user.favorite_brewery.first.name).to eq("anonymous")
    end
  end

  def create_beer_with_rating_style(object, score, object_style)
    beer = FactoryBot.create(:beer, style: object_style[:style])
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
    beer
  end

  def create_beer_with_rating(object, score)
    beer = FactoryBot.create(:beer)
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
    beer
  end

  def create_beers_with_many_ratings(object, *score)
    score.each do |score|
      create_beer_with_rating(object, score)
    end
  end
end
