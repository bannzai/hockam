require 'selenium-webdriver'

namespace :suzuri_scraper do
  desc 'suzuriのhockamのページからアイコン画像と情報を取得する'
  task scrape: :environment do
    puts 'Begin scrape'
    driver.get('https://suzuri.jp/hockam')

    # NOTE: とりあえず何回も一番下にスクロールするでおk
    (0...max).each { |num|
      driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
      sleep 5
    }

    names = driver.find_elements(:xpath, '//*[@id="products"]/div/div/div/a').map { |e| e.attribute('innerText') }
    categories = driver.find_elements(:xpath, '//*[@id="products"]/div/div/div[2]/div').map { |e| e.attribute('innerText') }
    links = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a')
    images = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a/div/img')
    external_links = driver.find_elements(:xpath, '//*[@id="products"]/div/div/a').map { |e| e.attribute('href') }
    count = links.count

    raise 'Unexpected difference count for scraped eleemnts' if count != images.count && count != categories.count && count != names.count && count != links.count && count != external_links.count

    puts "items count: #{links.count}"

    links.zip(names, categories, images, external_links).each { |link, name, category, image, external_link|
      show_url = link['href']
      image_url = image['data-original']
      item_id = item_id(show_url)

      puts "item_id: #{item_id}, name: #{name}, list_image_url: #{image_url}, category: #{category}, external_link: #{external_link}"

      suzuri_good = SuzuriGood.find_or_initialize_by(
        item_id: item_id,
        name: name,
        list_image_url: image_url,
        category: category,
        external_link: external_link
      ).save!
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
     Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'no-sandbox'])
  end

  def driver
    @driver ||= Selenium::WebDriver.for(:chrome, options: options)
  end

  def item_id(url)
    URI.parse(url).path.delete_prefix('/').split('/')[1]
  end
end
