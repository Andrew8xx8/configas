require "configas/version"
require "active_support/core_ext/hash"

module Configas  
  autoload 'Builder', 'configas/builder'
  autoload 'ProxyBuilder', 'configas/proxy_builder'
  autoload 'Config', 'configas/config'

  def self.build(env, &block)
    conf = Builder.build(env, &block)
    Config.new conf
  end

end


