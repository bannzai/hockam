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

    categories = driver.find_elements(:xpath, '//*[@id="products"]/div/div/div[2]/div')
    links = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a')
    images = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a/div/img')
    raise 'Unexpected difference count for scraped eleemnts' if links.count != images.count && links.count != categories.count

    puts "items count: #{links.count}"

    links.zip(images, categories).each { |link, image, category|
      name = link.attribute('innerText')
      category_name = category.attribute('innerText')
      show_url = link['href']
      image_url = image['data-original']
      item_id = item_id(show_url)

      puts "item_id: #{item_id}, name: #{name}, list_image_url: #{image_url}, category: #{category_name}"

      suzuri_good = SuzuriGood.find_or_initialize_by(item_id: item_id)
      suzuri_good.update_attributes!(name: name, list_image_url: image_url, category: category_name)
      suzuri_good.save!
    }

    driver.quit
    puts 'End scrape'
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

  def item_id(url)
    URI.parse(url).path.delete_prefix('/').split('/')[1]
  end
end
