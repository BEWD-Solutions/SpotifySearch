class TracksController < ApplicationController

	def index
		if params[:search]
			request = Typhoeus::Request.new(
			    URI.encode("https://api.spotify.com/v1/search?q=#{params[:search]}&type=track"),
			    method: :get
			)

			request.run

			tracks_json = JSON.parse(request.response.body)

			@tracks = tracks_json["tracks"]["items"]
		else
			@tracks = []
		end
	end

	def my_tracks
		request = Typhoeus::Request.new(
		    "https://api.spotify.com/v1/me/tracks",
		    method: :get,
		    headers: {
		    	"Authorization": "Bearer #{session[:spotify_token]}"
		    }
		)

		request.run

		tracks_json = JSON.parse(request.response.body)

		@songs = tracks_json["items"]
	end

end
