class YoutubeAllTimesController < ApplicationController
	def index
    	@entries = YoutubeAllTime.where(id < 21).paginate(page: params[:page], per_page: 10).order('viewcount desc')
    end
end
