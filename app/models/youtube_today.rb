class YoutubeToday < ActiveRecord::Base
	def link
		"https://youtube.com" + url
	end
end
