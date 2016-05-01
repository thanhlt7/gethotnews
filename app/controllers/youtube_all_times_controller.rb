class YoutubeAllTimesController < ApplicationController
	def index
    	@entries = YoutubeAllTime.all.paginate(page: params[:page], per_page: 10).order('viewcount desc')
    end
end
