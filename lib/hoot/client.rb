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
		end

		def push(message = nil)
			@credentials = Hoot::Keychain::credentials

			if message.nil?
				message = 'Hoot! Your command has completed! Come back!'
			end

			data = {
				:credentials => {
					:email => @credentials[0],
					:password => @credentials[1]
				},
				:message => message,
				:metadata => Hoot::Metadata.get
			}

			response = request('send', data)

			if response['result']
				abort('A Hoot was sent to your device.')
			end

			abort('A server error occurred.')
		end

		def authenticate(credentials)
			data = {
				:credentials => {
					:email => credentials[0],
					:password => credentials[1]
				}
			}

			response = request('authenticate', data)

			if response['result']
				Hoot::Keychain.save(credentials)
				abort('Authentication successful.')
			end

			puts 'Authentication failed.'

			Hoot::User::login
		end

		private

		def request(path, data)
			uri = URI.parse(@hedwig)
			http = Net::HTTP.new(uri.host, uri.port)

			unless ENV['DEV']
				http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_PEER
			end

			data = encode(data)

			request = Net::HTTP::Post.new("/api/v1/#{path}")
			request.add_field('Content-Type', 'application/json')
			request.set_form_data(data)
			response = http.request(request)

			JSON.parse(response.body)
		end

		# http://dev.mensfeld.pl/2012/01/converting-nested-hash-into-http-url-params-hash-version-in-ruby/

		def encode(value, key = nil, out_hash = {})
			case value
				when Hash  then
					value.each { |k,v| encode(v, append_key(key,k), out_hash) }
					out_hash
				when Array then
					value.each { |v| encode(v, "#{key}[]", out_hash) }
					out_hash
				when nil   then ''
				else
					out_hash[key] = value
					out_hash
			end
		end

		def append_key(root_key, key)
			root_key.nil? ? :"#{key}" : :"#{root_key}[#{key.to_s}]"
		end

	end
end
