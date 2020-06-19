require 'selenium-webdriver'
require 'pry'

namespace :suzuri_scaper do
  desc 'suzuriのhockamのページからアイコン画像と情報を取得する'
  task scraper: :environment do
    puts 'Begin scrape'
    driver.get('https://suzuri.jp/hockam')

    # NOTE: とりあえず何回も一番下にスクロールするでおk
    (0...max).each { |num|
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep 5
    }

    links = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a')
    images = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a/div/img')
    raise 'Unexpected difference count links and images' if links.count != images.count

    links.zip(images).each { |link, image| 
      show_url = link['href']
      image_url = image['data-original']
    }

    driver.quit
  end

  def max
    if ENV['RAILS_ENV'] == 'production'
      50
    else
      1
    end
  end

  def options
     Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
  end

  def driver
    @driver ||= Selenium::WebDriver.for(:chrome, options: options)
  end
end
