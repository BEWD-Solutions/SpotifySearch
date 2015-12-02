class TrackSavesController < ApplicationController

	def update
		request = Typhoeus::Request.new(
		    "https://api.spotify.com/v1/me/tracks",
		    method: :put,
		    params: {
		    	ids: params[:id]
		    },
		    headers: {
		    	"Authorization": "Bearer #{session[:spotify_token]}",
		    	"Content-Type": "application/json"
		    }
		)

		request.run

		redirect_to my_tracks_path
	end

	def destroy
		request = Typhoeus::Request.new(
		    "https://api.spotify.com/v1/me/tracks",
		    method: :delete,
		    params: {
		    	ids: params[:id]
		    },
		    headers: {
		    	"Authorization": "Bearer #{session[:spotify_token]}",
		    	"Content-Type": "application/json"
		    }
		)

		request.run

		redirect_to my_tracks_path
	end

end
