require 'rails_helper'

describe "Places" do
  before :each do 
    allow(WeathermappingApi).to receive(:weather_in).with('kumpula').and_return(
        Weather.new({"observation_time"=>"10:23 PM",
                      "temperature"=>6,
                      "weather_code"=>113,
                      "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0008_clear_sky_night.png"],
                      "weather_descriptions"=>["Clear"],
                      "wind_speed"=>30,
                      "wind_degree"=>290,
                      "wind_dir"=>"WNW",
                      "pressure"=>1002,
                      "precip"=>0,
                      "humidity"=>65,
                      "cloudcover"=>0,
                      "feelslike"=>1,
                      "uv_index"=>1,
                      "visibility"=>10,
                      "is_day"=>"no" }
      ))
    end

  it "If one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
      [ Place.new(name: 'Oljenkorsi', id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button('Search')

    # save_and_open_page
    expect(page).to have_content 'Oljenkorsi'
  end

  it "If three places are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
      [ Place.new(name: 'Oljenkorsi1', id: 1),
        Place.new(name: 'Oljenkorsi2', id: 2),
        Place.new(name: 'Oljenkorsi3', id: 3)
      ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button('Search')

    # save_and_open_page
    expect(page).to have_content 'Oljenkorsi1'
    expect(page).to have_content 'Oljenkorsi2'
    expect(page).to have_content 'Oljenkorsi3'
  end

  it "If no places are returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
      []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button('Search')

    # save_and_open_page
    expect(page).to have_content 'No locations in kumpula'
  end
end