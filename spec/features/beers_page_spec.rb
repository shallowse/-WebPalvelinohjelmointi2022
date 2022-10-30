require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    @user = FactoryBot.create :user
    sign_in(username: 'Pekka', password: 'Foobar1')
    FactoryBot.create :style, name: 'UserLager100', description: 'TODO'
    FactoryBot.create :style, name: 'UserLager200', description: 'TODO'
  end
  let!(:brewery) { FactoryBot.create :brewery, name: 'Koff' }

  it "can be created with a valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: 'iso 3')
    select('UserLager100', from: 'beer[style_id]') 
    select('Koff', from: 'beer[brewery_id]') 

    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.from(0).to(1)

    # save_and_open_page
    expect(page).to have_content 'Beer was successfully created.'
    expect(page).to have_content 'iso 3'
  end

  it "cannot be created with a non-valid name" do
    visit new_beer_path
    fill_in('beer[name]', with: '')
    select('UserLager100', from: 'beer[style_id]') 
    select('Koff', from: 'beer[brewery_id]') 

    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)

    # save_and_open_page
    expect(page).to have_content '1 error prohibited this beer from being saved:'
    expect(page).to have_content 'Name can\'t be blank'
  end
end