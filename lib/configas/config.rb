module Configas
  class Config
  	def initialize(config)
  		@storage = {}
  		config.each_pair do |key, value|  
  			if value.instance_of?(Hash)
  				@storage[key] = self.class.new(value)
  				@storage[key].define_singleton_method(:to_hash) { value }
  			else
  				@storage[key] = value
  			end

  			define_singleton_method(key) { @storage[key] }
  		end
  	end

  	def [](key)
  		@storage[key]
  	end
  end
 end