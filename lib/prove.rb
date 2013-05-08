require 'prove/client'
require 'prove/verification'
module Prove
  class << self
    attr_reader :client
    def api_key=(key)
      if @client
        @client.api_key = key
      else
        @client = Client.new(api_key: key)
      end
    end

    def configure(options, &block)
      @client = Client.new(options, &block)
    end 
  end

end
