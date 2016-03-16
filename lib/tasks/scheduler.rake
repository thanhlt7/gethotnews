namespace :scheduler do
  task feeds: [:environment] do
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse feed.url
      content.entries.each do |entry|
        like = get_total_like(entry.url)
        if like[0]['total_count'] > 100
          local_entry = feed.entries.where(title: entry.title).first_or_initialize
          local_entry.update_attributes(fblikes: like[0]['total_count'], author: entry.author, 
          url: entry.url, published: entry.published)
          p "Synced Entry - #{entry.title}"
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
end