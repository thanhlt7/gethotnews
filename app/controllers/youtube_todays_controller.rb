class YoutubeTodaysController < ApplicationController
	def index
    	@entries = YoutubeToday.where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)).paginate(page: params[:page], per_page: 10).order('viewcount desc')
    end
end
