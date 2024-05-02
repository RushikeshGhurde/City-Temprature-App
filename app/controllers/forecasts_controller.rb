require 'httparty'

class ForecastsController < ApplicationController
  def index
    @location = params[:location]
    @forecast = fetch_weather_forecast(@location) if @location
  end

  private

  def fetch_weather_forecast(location)
    # Replace 'your_api_key' with your actual API key from OpenWeatherMap
    response = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=bfe70302d5da14fd5f1cc607d22bd047")
    
    if response.code == 200
      weather_data = JSON.parse(response.body)
      # Extract relevant forecast information from weather_data
      # For example, you can access the temperature:
      temperature_kelvin = weather_data['main']['temp']
      temperature_celsius = temperature_kelvin - 273.15 # Convert temperature to Celsius
      return "Current temperature in #{location}: #{temperature_celsius.round(2)}°C"
    else
      return "Error fetching weather data: #{response.code}"
    end
  end
end
