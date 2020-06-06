require 'open-uri'
require 'nokogiri'

namespace :minne_scraper do
  desc 'minne の umioのページから商品画像と情報を取得する'
  task scrape: :environment do
    puts 'Hello, World'
    loop do
      items_document = document_for(items_url)
      item_ids = pick_minne_item_ids(items_document)
      break if item_ids.size.zero?
      item_ids.each { |item_id| 
        item_document = document_for(item_url(item_id))
        name = name(item_document)
        large_image_url = large_image_url(item_document)
        MinneGoods.upsert(item_id, name, large_image_url)
      }
      increment_page_index
    end
    notifiy_items_error if page_index == 1
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
  def pick_minne_item_ids(doc)
    item_detail_page_links(doc).map { |a_tag| a_tag['href'].scan(/[0-9]+/).first.to_i }
  end
  def item_detail_page_links(doc)
    doc.xpath('//*[@id="container"]/div/div/div/div/div/a')
  end
  def name(doc)
    doc.xpath('//*[@id="item_left"]/h1')[0].children&.to_s
  end
  def large_image_url(doc)
    doc.xpath("//img[@class='items-large-image']")[0].src
  end

  def notifiy_items_error
    # TODO:
  end
end
