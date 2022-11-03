# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = 50
breweries = 50
beers_in_brewery = 50
ratings_per_user = 30

(1..users).each do |i|
  User.create! username: "user_#{i}", password: "Passwd1", password_confirmation: "Passwd1", active: true, admin: false
end

(1..breweries).each do |i|
  Brewery.create! name: "Brewery_#{i}", year: 1900, active: true
end

bulk = Style.create! name: "Bulk", description: "cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create! name: "Beer #{b.id} -- #{i}", style: bulk, brewery: b
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new score: (1 + rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end

=begin
b1 = Brewery.create! name: "Koff", year: 1897, active: true
b2 = Brewery.create! name: "Malmgard", year: 2001, active: true
b3 = Brewery.create! name: "Weihenstephaner", year: 1040, active: true
b4 = Brewery.create! name: "Turun panimo", year: 2010, active: false

# styles from: https://www.beeradvocate.com/beer/styles/
Style.create! name: 'European Dark Lager', description: 'This style encompasses a wide range of dark beers including India Pale Lagers, Czech lagers, and lagers brewed with adjuncts or non-traditional ingredients. In time these entries will be moved into more accurate categories.'
Style.create! name: 'Cream Ale', description: 'Cream Ales, spawned from the American light lager style, are brewed as an ale though are sometimes finished with a lager yeast or with lager beer mixed into the final product. Adjuncts such as corn or rice are frequently used to lighten the body but it is not uncommon for smaller craft brewers to make all malt Cream Ales. Pale straw to pale gold in color, they were known to have a low degree of hop bittering yet some hop aroma. More recently, a number of breweries have put their stamp on the style by giving it more of a hoppy character, nudging it toward Imperial. Well carbonated and well attenuated.'
Style.create! name: 'American Pale Ale', description: 'Originally British in origin, this style is now popular worldwide and the use of local or imported ingredients produces variances in character from region to region. American versions tend to be cleaner and hoppier (with the piney, citrusy Cascade variety appearing frequently) than British versions, which are usually more malty, buttery, aromatic, and balanced. Pale Ales range in color from deep gold to medium amber. Fruity esters and diacetyl can vary from none to moderate, and hop aroma can range from lightly floral to bold and pungent. In general, expect a good balance of caramel malt and expressive hops with a medium body and a mildly bitter finish. '
Style.create! name: 'Berliner Weisse', description: 'Low in alcohol, refreshingly tart, and often served with a flavored syrup like Woodruff or raspberry, the Berliner-style Weisse presents a harmony between yeast and lactic acid. These beers are very pale in color, and may be cloudy as they are often unfiltered. Hops are not a feature of this style, but these beers often do showcase esters. Traditional versions often showcase Brettanomyces yeast. Growing in popularity in the U.S., where many brewers are now adding traditional and exotic fruits to the recipe, resulting in flavorful finishes with striking, colorful hues. These beers are incredible when pairing. Bitterness, alcohol and residual sugar are very low, allowing the beer’s acidity, white bread and graham cracker malt flavors to shine. Carbonation is very high, adding to the refreshment factor this style delivers. Many examples of this style contain no hops and thus no bitterness at all.'
Style.create! name: 'Baltic Porter', description: 'Porters of the late 1700\'s were quite strong compared to today\'s standards, easily surpassing 7 percent alcohol by volume. Some English brewers made a stronger, more robust version, to be shipped across the North Sea that they dubbed a Baltic Porter. In general, the style\'s dark brown color covered up cloudiness and the smoky, roasted brown malts and bitter tastes masked brewing imperfections. Historically, the addition of stale ale also lent a pleasant acidic flavor to the style, which made it quite popular. These issues were quite important given that most breweries at the time were getting away from pub brewing and opening up production facilities that could ship beer across the world.'
Style.create! name: 'Sahti', description: 'A farmhouse ale with roots in Finland, Sahti was first brewed by peasants in the 1500s. Turbid with tremendous body, a low-flocculating Finnish bakers yeast creates a cloudy unfiltered beer with an abundance of sediment. Its color usually falls somewhere between pale yellow and deep brown. Traditionally unhopped, juniper twigs used during the brewing process create balance, imparting an unusual resiny character and serving as a preservative. Meanwhile, exposure to wild yeast and bacteria gives Sahti its signature tartness.'

b1.beers.create! name: "Iso 3", style_id: 1
b1.beers.create! name: "Karhu", style_id: 2
b1.beers.create! name: "Tuplahumala", style_id: 3
b2.beers.create! name: "Huvila Pale Ale", style_id: 4
b2.beers.create! name: "X Porter", style_id: 5
b3.beers.create! name: "Hefeweizen", style_id: 6
b3.beers.create! name: "Helles", style_id: 1

# Create users
u1 = User.create! username: 'john', password: 'JOHN1', password_confirmation: 'JOHN1', admin: true, active: true
u2 = User.create! username: 'sarah', password:  'SARAH1', password_confirmation: 'SARAH1', admin: false, active: true

# Create ratings
u1_r1 = Rating.create! score: 1, beer_id: b1.beers.first.id, user_id: u1.id
u1_r1 = Rating.create! score: 2, beer_id: b1.beers.second.id,  user_id: u1.id

u1_r2 = Rating.create! score: 3, beer_id: b2.beers.first.id,  user_id: u1.id
u1_r2 = Rating.create! score: 4, beer_id: b2.beers.second.id,  user_id: u1.id

u1_r3 = Rating.create! score: 5, beer_id: b3.beers.first.id,  user_id: u1.id
u1_r3 = Rating.create! score: 6, beer_id: b3.beers.second.id,  user_id: u1.id

u2_r1 = Rating.create! score: 7, beer_id: b1.beers.first.id, user_id: u2.id
u2_r2 = Rating.create! score: 8, beer_id: b1.beers.second.id, user_id: u2.id

# Create beer clubs and add members
bc1 = BeerClub.new name: 'Kumpulan kaljakerho', founded: 2022, city: 'Helsinki'
bc1.members << u1
bc1.save

bc1.members << u2
bc1.save

bc2 = BeerClub.new name: 'Old pub', founded: 1922, city: 'Turku'
bc2.members << u2
bc2.save
=end
