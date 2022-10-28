require 'rails_helper'

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: 'Koff' }

  it "can be created with a valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'iso 3')
    select('Lager', from: 'beer[style]') 
    select('Koff', from: 'beer[brewery_id]') 

    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.from(0).to(1)

    # save_and_open_page
    expect(page).to have_content 'Beer was successfully created.'
    expect(page).to have_content 'Name: iso 3'
  end

  it "cannot be created with a non-valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select('Lager', from: 'beer[style]') 
    select('Koff', from: 'beer[brewery_id]') 

    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)

    expect(page).to have_content '1 error prohibited this beer from being saved:'
    expect(page).to have_content 'Name can\'t be blank'
  end
end