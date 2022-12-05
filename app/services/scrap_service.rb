# frozen_string_literal: true
# Service class for scrapping data
require 'selenium-webdriver'

class ScrapService
  WAIT = Selenium::WebDriver::Wait.new(timeout: 30) # Maximum wait to find out search results html
  # WEB_DRIVER = Selenium::WebDriver.for :firefox

  def self.call(url)
    # options = Selenium::WebDriver::Firefox::Options.new(args: %w[--headless -disable-dev-shm-usage -no-sandbox])
    # driver = Selenium::WebDriver.for(:firefox, capabilities: [options])
    # driver.manage.timeouts.page_load = 120
    # driver.get url
    # Nokogiri::HTML(driver.page_source)
    client = Selenium::WebDriver::Remote::Http::Default.new
    options = Selenium::WebDriver::Firefox::Options.new(args: %w[--headless -disable-dev-shm-usage -no-sandbox])
    client.read_timeout = 600 # seconds
    driver = Selenium::WebDriver.for(:firefox, capabilities: [options], http_client: client)
    WAIT.until { driver.get url }
    #WAIT.until { driver.find_element(css: '.B_NuCI').displayed? }
    # driver.get url
    puts Nokogiri::HTML(driver.page_source)
  end
end
