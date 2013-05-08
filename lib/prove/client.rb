require "faraday"
require 'faraday_middleware'
require "logger"

module Prove
  class Client
    attr_accessor :api_key, :connection

    DEFAULTS = {faraday_adapter: Faraday.default_adapter,
      logger: Logger.new(STDOUT),
      scheme: :https,
      port: 443,
      host: 'getprove.com'}

    def initialize(options={}, &block)

      config = DEFAULTS.merge(options)

      block = block_given? ? block : Proc.new do |cxn|
        cxn.request  :json
        cxn.response :logger, config[:faraday_adapter] 
        cxn.response :json
        # cxn.response :raise_error  # raise exceptions on 40x, 50x responses
        cxn.adapter config[:faraday_adapter] 
      end
      
      url_builder = config[:scheme] == :http ? URI::HTTP : URI::HTTPS
      url = url_builder.build(host: config[:host], port: config[:port])

      @connection = Faraday.new(url, &block)     
      self.api_key = config[:api_key]
    end

    def api_key=(key)
      @api_key = key
      @connection.basic_auth(@api_key, '')
    end

    def get(url, &block)
      @connection.get(url, &block) 
    end

    def post(url, &block)
      @connection.post(url, &block)
    end
  end
end
