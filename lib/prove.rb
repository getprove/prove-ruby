require 'prove/client'
module Prove
  attr_reader :client
  def self.api_key=(key)
    if @client
      @client.api_key = key
    else
      @client = Client.new(api_key: key)
    end
  end

  def self.configure(options, &block)
    @client = Client.new(options, &block)
  end 
end
