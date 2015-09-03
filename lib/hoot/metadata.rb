require 'yaml'

module Hoot
  module Metadata
    @path = "#{ENV['HOME']}/.hoot/metadata.yml"

    public

    def self.set(key, value)
      return if value.nil?
      return unless keys.include?(key)
      create unless File.exist?(@path)

      if File.exist?(@path)
        @m = YAML::load_file(@path)
      end

      if @m.nil? || @m == false
        @m = {}
      end

      if valid?(key, value)
        # key = key.to_s Still not sure if I want to remove the ':' from the .yml file.
        @m[key] = value
        save
      else
        abort('You are trying to set invalid options.')
      end
    end

    def self.get
      return YAML::load_file(@path) if File.exist?(@path)
    end

    def self.save
      if File.write(@path, @m.to_yaml)
        true
      else
        false
      end
    end

    protected

    def self.create
      path = "#{ENV['HOME']}/.hoot/"
      Dir.mkdir(path) unless File.exists?(path)
      File.new(@path, 'w')
    end

    def self.valid?(key, value)
      return false unless keys.include?(key)
      return true unless key == :device=
      return false unless values.include?(value.to_sym)
    end

    def self.keys
      [
        :description,
        :device
      ]
    end

    def self.values
      [
        :server,
        :laptop,
        :desktop
      ]
    end

  end
end
