require 'nokogiri'
require 'open-uri'
require 'fastimage'

namespace :scheduler do
  task feeds: [:environment] do
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse feed.url
      content.entries.each do |entry|
        if entry.url != nil && entry.url != ""
          like = get_total_like(entry.url)
          p "#{like}"
          p "#{entry.url}"
          if like[0]['total_count'] > 100 && like[0]['total_count'] < 100000
            needed_image = get_image_url(entry.url)
            p "#{needed_image}"
            if needed_image != "" && needed_image != nil
              local_entry = feed.entries.where(title: entry.title).first_or_initialize
              local_entry.update_attributes(fblikes: like[0]['total_count'], author: entry.author, 
              url: entry.url, published: entry.published, category_id: feed.category_id, image_url: needed_image)
              p "Synced Entry - #{entry.title}"
            end
          end
        end
      end
      p "Synced Feed - #{feed.name}"
    end
  end

  def http_get(domain,path,params)
    return Net::HTTP.get(domain, "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&'))) if not params.nil?
    return Net::HTTP.get(domain, path)
  end

  def get_total_like(url)
    params = {
        :query => 'SELECT total_count FROM link_stat WHERE url = "' + url + '"',
        :format => 'json'
    }

    http = http_get('api.facebook.com', '/method/fql.query', params)
    data = ActiveSupport::JSON.decode(http)
  end

  def get_image_url(url)
    doc = Nokogiri::HTML(open(url))
    data = doc.css('img')
      data.each do |image|
        if image['src'].split('.').last != "gif"
          imgSize = FastImage.size(image['src'])
          if imgSize.first.to_i > 399
            return image['src']
            break
          end
        end
      end
  end
end