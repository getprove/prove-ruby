require 'prove'
describe Prove::Verification do
  RSpec::Matchers.define :be_a_populated_verification do
    match do |v|
      any_nil_attr = Prove::Verification::ACCESSORS.map{|i| v.send(i)}.any?(&:nil?)
      !v.nil? and v.kind_of?(Prove::Verification) and !any_nil_attr
    end

    failure_message_for_should do |v|
      if v.nil?
        "expected that #{v} would not be nil" 
      elsif !v.kind_of?(Prove::Verification)
        "expected that #{v} was a kind of Prove::Verification"
      else
       nil_attr = Prove::Verification::ACCESSORS.map{|i| v.send(i)}.select(&:nil?)
       "expected that #{v} would not have nil attributes #{nil_attr}"
      end
    end
  end

  before(:all) do
    Prove.api_key = ENV['PROVE']
  end

  it "should be initializable" do
    v = Prove::Verification.new({
      id: "awoeif128912938",
      tel: "1234567890",
      text: true,
      call: false,
      verified: false
    })
    expect(v).to be_a_populated_verification
  end

  it "Verification#list should return a list of Verifications" do 
    verifications = Prove::Verification.list
    expect(verifications).to_not be_nil
    expect(verifications).to be_kind_of Array
  end

  it "Verification#create should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    expect(v).to be_a_populated_verification
    expect(v.verified).to be_false
  end

  it "Verification#create with hash should return a populated verification" do 
    v = Prove::Verification.create(tel: "1234567890")
    expect(v).to be_a_populated_verification
    expect(v.verified).to be_false
  end

  it "Verification#verify with ordered params should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    v = Prove::Verification.verify(v.id, 1337) 
    expect(v).to be_a_populated_verification
    expect(v.verified).to be_true
  end

  it "Verification#verify with hash params should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    v = Prove::Verification.verify(id: v.id, pin: 1337) 
    expect(v).to be_a_populated_verification
    expect(v.verified).to be_true
  end

  it "#retrieve should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    v = v.retrieve
    expect(v).to be_a_populated_verification
  end

  it "#verify should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    v = v.verify(1337) 
    expect(v).to be_a_populated_verification
    expect(v.verified).to be_true
  end

  it "#verify should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    v = v.verify(pin: 1337) 
    expect(v).to be_a_populated_verification
    expect(v.verified).to be_true
  end

  it "#retrieve should return a populated verification" do 
    v = Prove::Verification.create("1234567890")
    v = v.retrieve
    expect(v).to be_a_populated_verification
  end
end
