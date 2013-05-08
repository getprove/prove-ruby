require "faraday"
require 'faraday_middleware'
require "logger"

module Prove
  class Client
    attr_accessor :api_key, :connection

    DEFAULTS = {faraday_adapter: Faraday.default_adapter,
      log_level: :warn,
      logger: Logger.new(STDOUT),
      scheme: :https,
      port: 443,
      host: 'getprove.com'}

    def initialize(options={}, &block)
      config = DEFAULTS.merge(options)

      if !options.has_key?(:logger) or (options.has_key?(:log_level) and options.has_key?(:logger))
        config[:logger].level = Logger.const_get(config[:log_level].to_s.upcase)
      end

 
      block = block_given? ? block : Proc.new do |cxn|
        cxn.request  :url_encoded
        cxn.response :logger, config[:logger] 
        cxn.response :json
        # cxn.response :raise_error  # raise exceptions on 40x, 50x responses
        cxn.adapter config[:faraday_adapter] 
      end
      
      url_builder = config[:scheme] == :http ? URI::HTTP : URI::HTTPS
      url = url_builder.build(host: config[:host], port: config[:port])

      @connection = Faraday.new(url, &block)     
      @connection.headers['User-Agent'] = "Prove-Ruby"

      self.api_key = config[:api_key]
    end

    def api_key=(key)
      @api_key = key
      @connection.basic_auth(@api_key, '')
    end

    def get(url, options = {}, &block)
      return @connection.get(url, options, &block) 
    end

    def post(url, options = {}, &block)
      return @connection.post(url, options, &block)
    end
  end
end
