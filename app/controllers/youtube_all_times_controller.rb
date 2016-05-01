class YoutubeAllTimesController < ApplicationController
	def index
    	@entries = YoutubeAllTime.limit(20).paginate(page: params[:page], per_page: 10).order('viewcount desc')
    end
end
