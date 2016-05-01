require 'nokogiri'
require 'open-uri'

namespace :mostviewedyt do
  task mostviewedalltime: [:environment] do
  	    url = "https://www.youtube.com/results?search_sort=video_view_count&filters=video&search_query=site%3Ayoutube.com"
    	  get_video_info(url)
    end

  task mostviewedtoday: [:environment] do
        url = "https://www.youtube.com/results?search_sort=video_view_count&filters=today%2C+video&search_query=site%3Ayoutube.com"
        get_video_today(url)
    end
  end

  def get_video_today(url)
      result = get_information(url)
      for i in 0..10
        local_entry = YoutubeToday.where(url: result[0][i]).first_or_initialize
        local_entry.update_attributes(title: result[3][i], image_url: result[4][i], 
          time: result[1][i], viewcount: result[2][i])
        p "#{result[1][i]}"
      end
  end

  def get_video_info(url)
      result = get_information(url)
      for i in 0..19
        local_entry = YoutubeAllTime.where(url: result[0][i]).first_or_initialize
        local_entry.update_attributes(title: result[3][i], image_url: result[4][i], 
          time: result[1][i], viewcount: result[2][i])
        p "#{result[1][i]}"
      end
  end

  def get_information(url)
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    data = doc.css('.yt-lockup-title a')
    alllink = Array.new
    alltime = Array.new
    allviews = Array.new
    titles = Array.new
    allimages = Array.new
    result = Array.new
      data.each do |href|
        link = href['href']
          alllink << link
      end
      result << alllink
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
            allviews << timeandview[1]
          end
      end
      result << alltime
      result << allviews
    data = doc.css('.yt-uix-tile-link')
      data.each do |title|
        title = title.text.encode(Encoding::ISO_8859_1).force_encoding("utf-8")
        titles << title
      end
      result<< titles
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
      result << allimages

      return result
  end

  