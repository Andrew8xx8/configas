module Configas
  class ProxyBuilder
    attr_accessor :config

    def self.build(&block)
      proxy = new &block
      proxy.config
    end

    def initialize(&block)      
      @config = {}
      instance_eval &block
    end 

    def method_missing(method,*args,&block)
      if block.nil? 
        @config[method] = args.first
      else
        @config[method] = self.class.build(&block)
      end
    end
  end
end