class YoutubeAllTimesController < ApplicationController
	def index
    	@entries = YoutubeAllTime.all.paginate(page: params[:page], per_page: 6).order('id asc')
    end
end