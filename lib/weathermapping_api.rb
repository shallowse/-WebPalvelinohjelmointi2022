class WeathermappingApi
  def self.weather_in(city)
    city_weather = "#{city.downcase}-weather"

    weather = Rails.cache.read(city_weather)
    return weather if weather

    weather = get_weather_in(city)
    Rails.cache.write(city_weather, weather, expires_at: 1.hour.from_now)
    weather
  end

  def self.get_weather_in(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    return [] if response['success'] == false

    Weather.new(response['current'])
  end

  def self.key
    return nil if Rails.env.test? # Testatessa ei apia tarvita
    raise 'WEATHERDATA_APIKEY env variable not defined' if ENV['WEATHERDATA_APIKEY'].nil?

    ENV.fetch('WEATHERDATA_APIKEY')
  end
end
