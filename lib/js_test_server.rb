dir = File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path("#{dir}/../vendor/lucky-luciano/lib")
require "lucky_luciano"

require "timeout"
require "selenium/client"
require "trollop"
require "json"
require "erector"

Erector::Widget.prettyprint_default = true

require "#{dir}/js_test_server/configuration"
require "#{dir}/js_test_server/server"
require "#{dir}/js_test_server/client"

module JsTestServer
  class << self
    Configuration.instance = Configuration.new

    def method_missing(method_name, *args, &block)
      if Configuration.instance.respond_to?(method_name)
        Configuration.instance.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end
