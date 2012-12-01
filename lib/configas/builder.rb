module Configas
  class Builder
    attr_accessor :config

    def self.build(env, &block)
      builder = new &block

      unless builder.config[env][:parent].nil?
        builder.config[env][:config] = builder.config[builder.config[env][:parent]][:config].deep_merge builder.config[env][:config]
      end

      builder.config[env][:config]
    end

    def initialize(&block)
      @config = {}
      instance_eval &block
    end 

    def env(env, options = nil, &block)
      @config[env] = { config: {} }

      if block
        proxy = ProxyBuilder.new &block
        @config[env][:config] = proxy.config 
      end

      @config[env] = @config[env].merge options if options
    end
  end
end