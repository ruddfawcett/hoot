require 'commander/import'

module Hoot
	module User
		@client = Hoot::Client.new

		def self.login
			puts 'Enter your Hoot credentials.'

			email = ask 'Email: '
			password = Digest::SHA1.hexdigest(password 'Password: ', '*')
			credentials = [email, password]

			@client.authenticate(credentials)
		end

		def self.logout
			Hoot::Keychain.destroy
		end

	end
end
