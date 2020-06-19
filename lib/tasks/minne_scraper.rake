require 'open-uri'
require 'nokogiri'

namespace :minne_scraper do
  desc 'minne の umioのページから商品画像と情報を取得する'
  task scrape: :environment do
    puts 'Begin scrape'
    loop do
      items_document = document_for(items_url)
      elements = item_elements(items_document)
      break if elements.size.zero?
      elements.each { |element|
        item_id = pick_minne_item_id(element)
        list_image_url = list_image_url(element)
        name = name(element)
        puts "item_id: #{item_id}, name: #{name}, list_image_url: #{list_image_url}"
        MinneGood.upsert(item_id: item_id, name: name, list_image_url: list_image_url, unique_by: :item_id)
      }
      increment_page_index
    end
    notifiy_items_error if page_index == 1
    puts 'End scrape'
  end

  private
  def page_index
    @page_index ||= 1
  end
  def increment_page_index
    @page_index += 1
  end

  def items_url
    "https://minne.com/@umio?boost_by[hot_limit][factor]=5&boost_by[sales_quantity_limit][factor]=10&boosts[]=product_name^10&boosts[]=description^1&boosts[]=tags.name^10&boosts[][nick_name^1]=autocomplete&boosts[][product_name^0.5]=word_start&keywords=&page=#{page_index}&per_page=20&sort=position"
  end
  def item_url(item_id)
    "https://minne.com/items/#{item_id}"
  end

  def document_for(url) 
    charset = 'utf-8'
    Nokogiri::HTML.parse(open(url), nil, charset)
  end
  def item_elements(doc)
    doc.xpath('//*[@class="galleryProduct"]')
  end
  def pick_minne_item_id(doc)
    item_detail_page_link(doc).scan(/[0-9]+/).first.to_i
  end
  def item_detail_page_link(doc)
    doc.search('.galleryProduct__productName a').attribute('href').value
  end
  def name(doc)
    doc.search('.galleryProduct__productName a').attribute('data-product-name').value
  end
  def list_image_url(doc)
    doc.search('.galleryProduct__media div').attribute('data-bg').value
  end

  def notifiy_items_error
    # TODO:
  end
end
