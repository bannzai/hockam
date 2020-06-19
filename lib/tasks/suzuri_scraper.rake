require 'selenium-webdriver'

namespace :suzuri_scaper do
  desc 'suzuriのhockamのページからアイコン画像と情報を取得する'
  task scraper: :environment do
    puts 'Begin scrape'
    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.get('https://suzuri.jp/hockam')
    # NOTE: とりあえず何回も一番下にスクロールするでおk
    (0...max).each { |num|
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep 5
    }
    result = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a/div/img')
    puts "result.count: #{result.count}"
    puts driver.title
    driver.quit
  end

  def max
    if ENV['RAILS_ENV'] == 'production'
      50
    else
      3
    end
  end
end
