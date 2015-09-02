require 'netrc'
require 'io/console'
require 'digest/sha1'

module Hoot
	module User
		@n = Netrc.read
			
		def self.isAuthenticated?
			@n = Netrc.read
			login, password = @n['hedwig.herokuapp.com']

			if login.nil? || password.nil?
				false
			else
				true
			end
		end

		def self.form
			puts 'Please enter your Hoot credentials.'

			print 'Email: '
			login = gets.chomp

			while login.length == 0
				puts 'Please enter an email...'
				print 'Email: '
				login = gets.chomp
			end

			if STDIN.respond_to?(:noecho)
			  def self.get_password(prompt='Password: ')
			    print prompt
			    STDIN.noecho(&:gets).chomp
			  end
			else
			  def self.get_password(prompt='Password: ')
			    `read -s -p '#{prompt}' password; echo $password`.chomp
			  end
			end

			password = self.get_password

			while password.length == 0
				puts 'Please enter a password...'
				password = self.get_password
			end

			password = Digest::SHA1.hexdigest(password)

			[login, password]
		end


		def self.authenticate
			credentials = self.form

			@n['hedwig.herokuapp.com'] = credentials[0], credentials[1]
			@n.save

			puts
			puts 'Your credentials have been saved.'
		end

		def self.credentials
			if self.isAuthenticated?
				login, password = @n['hedwig.herokuapp.com']

				[login, password]
			else
				self.authenticate	
			end
		end
	end
end