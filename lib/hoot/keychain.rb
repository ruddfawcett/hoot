require 'netrc'
require 'digest/sha1'

module Hoot
  module Keychain
    @n = Netrc.read

    public

    def self.authenticated?
      login, password = @n['hedwig.herokuapp.com']

      if (login.nil? || login == 0) || (password.nil? || password == 0)
        return false
      end
      return true
    end

    def self.credentials
      if authenticated?
        return @n['hedwig.herokuapp.com']
      end
      nil
    end

    def self.save(credentials)
      @n['hedwig.herokuapp.com'] = credentials[0], credentials[1]
      @n.save
    end

    def self.destroy
      @n['hedwig.herokuapp.com'] = 0, 0
      @n.save
      abort('You were logged out.')
    end

  end
end
