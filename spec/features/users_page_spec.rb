require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    @user = FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: 'Pekka', password: 'Foobar1')
      # save_and_open_page

      expect(page).to have_content 'Welcome back'
      expect(page).to have_content 'Pekka!'
    end

    it "is redirected back to signin form if wrong credentials are given" do
      sign_in(username: 'Pekka', password: 'wrong')
      # save_and_open_page

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')

      expect {
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  describe "when on user's page (signed up)" do 
    before :each do
      brewery = FactoryBot.create :brewery, name: 'Koff' 
      beer1 = FactoryBot.create :beer, name: 'iso 3', style: 'Lager', brewery: brewery 
      beer2 = FactoryBot.create :beer, name: 'Karhu', style: 'IPA', brewery: brewery 
      beer3 = FactoryBot.create :beer, name: 'iso 4', style: 'RandNew', brewery: brewery 

      user2 =  FactoryBot.create :user, username: 'Test1', password: 'Test1', password_confirmation: 'Test1'

      rating1 =  FactoryBot.create :rating, score: 10, beer: beer1, user: @user
      rating2 =  FactoryBot.create :rating, score: 20, beer: beer2, user: @user
      rating3 =  FactoryBot.create :rating, score: 30, beer: beer3, user: user2
    end

    it "shows the correct number of ratings" do
      sign_in(username: 'Pekka', password: 'Foobar1')

      # visit user_path(@user)
      # save_and_open_page
      expect(page).to have_content "Pekka\nHas made 2 ratings, average rating 15.0"
      expect(page).to have_content 'iso 3'
      expect(page).to have_content 'Karhu'
      expect(page).to have_no_content 'iso 4'
    end

    it "deleting rating deletes it from the database" do
      sign_in(username: 'Pekka', password: 'Foobar1')

      # puts html
      # save_and_open_page
      expect {
        page.all('a', text: 'Delete')[0].click
      }.to change{Rating.count}.from(3).to(2)

      # visit user_path(@user)
      # save_and_open_page
    end

    it "shows the favorite style of the user" do
      sign_in(username: 'Pekka', password: 'Foobar1')

      #save_and_open_page
      expect(page).to have_content "favorite style\nIPA\n"
    end

    it "shows the favorite brewery of the user" do
      brewery = FactoryBot.create :brewery, name: 'NewBeer'
      beer1 = FactoryBot.create :beer, name: 'new 1', style: 'NewLager', brewery: brewery 
      rating1 =  FactoryBot.create :rating, score: 45, beer: beer1, user: @user

      sign_in(username: 'Pekka', password: 'Foobar1')

      # save_and_open_page
      expect(page).to have_content "favorite style\nNewLager\n"
      expect(page).to have_content "favorite brewery\nNewBeer"
    end
  end
end