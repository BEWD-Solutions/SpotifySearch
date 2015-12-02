class AuthenticationsController < ApplicationController
	def create
		request = Typhoeus::Request.new(
		    "https://accounts.spotify.com/api/token",
		    method: :post,
		    params: {
		    	grant_type: "authorization_code",
		    	code: params[:code],
		    	redirect_uri: "http://localhost:3000/auth",
		    	client_id: ENV["spotify_client_id"],
		    	client_secret: ENV["spotify_client_secret"]
		    }
		)

		request.run

		response = request.response.body

		response_json = JSON.parse(response)

		session[:spotify_token] = response_json["access_token"]

		redirect_to tracks_path
	end

	def destroy
		reset_session

		redirect_to tracks_path
	end
end
