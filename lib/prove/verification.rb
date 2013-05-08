module Prove
  class Verification
    ACCESSORS = [:id, :tel, :text, :call, :verified]
    attr_accessor *ACCESSORS

    def initialize(attr_hash={})
      attr_hash.each do |key, val|
        self.instance_variable_set("@#{key}", val)
      end
    end

    def self.create(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      tel = args[0] || options[:tel]
      from_json Prove.client.post('/api/v1/verify', {tel: tel}).body
    end

    def self.list
      from_json_array Prove.client.get('/api/v1/verify').body
    end

    def self.verify(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      id = args[0] || options[:id]
      pin = args[1] || options[:pin]

      from_json Prove.client.post('/api/v1/verify/' + id + '/pin', {pin: pin}).body
    end

    def self.retrieve(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      id = args[0] || options[:id]
      from_json Prove.client.get('/api/v1/verify/' + id).body
    end

    def verify(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      pin = args[0] || options[:pin]
      self.class.verify(self.id, pin)
    end

    def retrieve
      self.class.retrieve(self.id)
    end

    def to_json
      return {id: self.id, 
        tel: self.tel,
        text: self.text, 
        call: self.call, 
        verified: self.verified}.to_json
    end

    def self.from_json(verification_hash)
      return Verification.new(verification_hash)
    end

    def self.from_json_array(verifications)
      return verifications.map{|attr_hash| Verification.new(attr_hash)}
    end
  end
end
