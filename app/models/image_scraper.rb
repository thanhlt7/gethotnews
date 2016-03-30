require 'nokogiri'
require 'open-uri'

class ImageScraper

  attr_reader :url, :data

  def initialize(url)
    @url = url
  end

  def get_class_items
    data.select{|img| img[:src] if img[:width].to_i > 400}
  end

  def data
    @data = Nokogiri::HTML(open(url))
  end

end