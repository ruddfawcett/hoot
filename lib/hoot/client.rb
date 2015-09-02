require 'json'
require 'net/https'
require 'uri'

module Hoot
	unless ENV['DEV']
		HEDWING_ENDPOINT = 'https://hedwig.herokuapp.com'
	else
		HEDWING_ENDPOINT = 'http://localhost:5000'
	end

	class Client
		attr_accessor :hedwig
		attr_accessor :credentials

	    def initialize
	    	@hedwig = ENV['HEDWING_ENDPOINT'] || HEDWING_ENDPOINT
	     	@credentials = Hoot::User::credentials
	    end

	    def send
	    	# TODO: Custom messages

	    	response = request(@hedwig)
	    	response = JSON.parse(response.body)

	    	if response['error']
	    		abort('A server error occurred.')
	    	end

	    	if response['result']
	    		abort('A Hoot was sent to your device.')
	    	end
	    end

	    private

	    def request(uri)
			uri = URI.parse(uri)
			http = Net::HTTP.new(uri.host, uri.port)

			unless ENV['DEV']
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_PEER
			end

			request = Net::HTTP::Post.new('/api/v1/send')
			request.add_field('Content-Type', 'application/json')
			request.set_form_data({'credentials[email]' => @credentials[0], 'credentials[password]' => @credentials[1]})
			response = http.request(request)

			response
	    end
	end
end