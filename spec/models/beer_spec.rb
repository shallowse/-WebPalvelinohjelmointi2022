require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "Beer with a brewery" do
    let(:brewery) { Brewery.create name: "Koff", year: 1897 }
    let(:style) { Style.create name: 'European Dark Lager', description: 'TODO' }

    it "and name and style is created" do
      beer = brewery.beers.create name: "Iso 3", style_id: style.id

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not saved without a name" do
      beer = brewery.beers.create style_id: style.id

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = brewery.beers.create name: "Iso 3"

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
