require 'nokogiri'
require 'open-uri'

namespace :mostviewedyt do
  task mostviewedalltime: [:environment] do
  	    url = "https://www.youtube.com/results?search_sort=video_view_count&filters=video&search_query=site%3Ayoutube.com"
    	get_video_info(url)
    end
  end

  def get_video_info(url)
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    data = doc.css('.yt-lockup-title a')
    alllink = Array.new
    alltime = Array.new
    allviews = Array.new
    titles = Array.new
    allimages = Array.new
      data.each do |href|
      	link = href['href']
          alllink << link
      end
    data = doc.css('.yt-lockup-meta-info')
      data.each do |info|
      	str = "ago"
        p "Start #{info}"
         newinfo = info.text
      	  if newinfo.include?(str)
            p "New #{newinfo}"
      	  	newinfo = newinfo.gsub(/ago/,'ago~')
      	  	timeandview = newinfo.split('~')
      	    alltime << timeandview[0]
            num_view = timeandview[1].gsub(/views/,'')
            allviews << num_view
      	  end
      end
    data = doc.css('.yt-uix-tile-link')
      data.each do |title|
        title = title.text.encode(Encoding::ISO_8859_1).force_encoding("utf-8")
        titles << title
      end
    data = doc.css('.yt-thumb-simple img')
      data.each do |image|
        img = ""
        if image['src'].include?('.jpg')
          img = image['src']
        else
          img = image['data-thumb']
        end
          allimages << img
      end
      
      for i in 0..19
        local_entry = YoutubeAllTime.where(url: alllink[i]).first_or_initialize
        local_entry.update_attributes(title: titles[i], image_url: allimages[i], time: alltime[i], viewcount: allviews[i])
        p "#{allviews[i]}"
      end
  end