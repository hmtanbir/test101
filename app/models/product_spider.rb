class ProductSpider < Kimurai::Base
  @name = 'product_spider'
  @engine = :mechanize
  # @start_urls = ['https://github.com/search?q=Ruby%20Web%20Scraping']
  # @config = {
  #   user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36',
  #   before_request: { delay: 4..7 }
  # }

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//div[@class='shop-srp-listings__listing-container']").each do |vehicle|
      item = {}

      item[:title]      = vehicle.css('h2.listing-row__title')&.text&.squish
      item[:price]      = vehicle.css('span.listing-row__price')&.text&.squish&.delete('^0-9').to_i
      item[:stock_type] = vehicle.css('div.listing-row__stocktype')&.text&.squish
      item[:miles]      = vehicle.css('span.listing-row__mileage')&.text&.squish&.delete('^0-9').to_i
      item[:exterior_color] = vehicle.css('ul.listing-row__meta li')[0]&.text&.squish.gsub('Ext. Color: ', '')
      item[:interior_color] = vehicle.css('ul.listing-row__meta li')[1]&.text&.squish.gsub('Int. Color: ', '')
      item[:transmission] = vehicle.css('ul.listing-row__meta li')[2]&.text&.squish.gsub('Transmission: ', '')
      item[:drivetrain]   = vehicle.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')

      puts item
    end
  end

end
