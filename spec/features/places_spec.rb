require 'rails_helper'

describe "Places" do
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
    allow(BeermappingApi).to receive(:places_in).with('kumpula3').and_return(
      [ Place.new(name: 'Oljenkorsi1', id: 1),
        Place.new(name: 'Oljenkorsi2', id: 2),
        Place.new(name: 'Oljenkorsi3', id: 3)
      ]
    )

    visit places_path
    fill_in('city', with: 'kumpula3')
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