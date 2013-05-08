require "json"
module Prove
  class Verification
    attr_accessor :id, :tel, :text, :call, :verified

    def initialize(attr_hash={})
      attr_hash.each do |key, val|
        self.instance_variable_set(key, val)
      end
    end

    def self.create(tel)
      from_json Prove.client.post('/api/v1/verify', {tel: tel}).body
    end

    def self.list
      from_json_array Prove.client.get('/api/v1/verify').body
    end

    def self.verify(id, pin)
      from_json Prove.client.post('/verify/' + id + '/pin', {pin: pin}).body
    end

    def self.get(id)
      from_json Prove.client.get('/verify/' + id).body
    end

    def verify(pin)
      self.class.verify(self.id, pin)
    end

    def get
      self.class.get(self.id)
    end

    def to_json
      return {id: self.id, 
        tel: self.tel,
        text: self.text, 
        call: self.call, 
        verified: self.verified}.to_json
    end

    def self.from_json(string)
      attr_hash = JSON.load(string)
      return Verification.new(attr_hash)
    end

    def self.from_json_array(string)
      verifications = JSON.load(string)
      return verifications.map{|attr_hash| Verification.new(attr_hash)}
    end

  end
end
