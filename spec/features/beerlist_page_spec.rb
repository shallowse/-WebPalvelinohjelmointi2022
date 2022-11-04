require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new app, browser: :chrome,
        options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
    end

    Capybara.javascript_driver = :chrome
    # WebMock.disable_net_connect!(allow_localhost: true)
    # Nämä testit eivät github actionsissa enää jossain vaiheessa toimineet ilman ao. muutosta
    # https://stackoverflow.com/a/22976546
    WebMock.allow_net_connect!
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager", description: "TEST"
    @style2 = Style.create name: "Rauchbier", description: "TEST"
    @style3 = Style.create name: "Weizen", description: "TEST"
    @beer1 = FactoryBot.create(:beer, name: "Gin", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    # find('table').find('tr:nth-child(2)')
    # find('table')
    # save_and_open_page
    expect(page).to have_content "Gin"
  end

  it "shows the beers in alphabetical order", js:true do
    visit beerlist_path

    first = find('.tablerow:nth-of-type(1)').text
    expect(first).to have_content "Fastenbier"

    second = find('.tablerow:nth-of-type(2)').text
    expect(second).to have_content "Gin"

    third = find('.tablerow:nth-of-type(3)').text
    expect(third).to have_content "Lechte Weisse"

    #binding.pry
  end

  it "shows the beers in correct order when style is clicked", js:true do
    visit beerlist_path

    #binding.pry
    find('#style').click

    first = find('.tablerow:nth-of-type(1)').text
    expect(first).to have_content "Gin"

    second = find('.tablerow:nth-of-type(2)').text
    expect(second).to have_content "Fastenbier"

    third = find('.tablerow:nth-of-type(3)').text
    expect(third).to have_content "Lechte Weisse"
  end

  it "shows the beers in correct order when brewery is clicked", js:true do
    visit beerlist_path

    find('#brewery').click

    first = find('.tablerow:nth-of-type(1)').text
    expect(first).to have_content "Lechte Weisse"

    second = find('.tablerow:nth-of-type(2)').text
    expect(second).to have_content "Gin"

    third = find('.tablerow:nth-of-type(3)').text
    expect(third).to have_content "Fastenbier"

    #binding.pry
  end
end
