require 'prove'
describe Prove do
  it "should have an env variable with secret key" do
    expect(ENV['PROVE']).to_not be_nil
  end 

  it "should be initializable with an api key" do
    Prove.api_key = ENV['PROVE']
    expect(Prove.client).to_not be_nil
  end

  it "should be configurable with an api key" do
    Prove.configure(api_key: ENV['PROVE'])
    expect(Prove.client).to_not be_nil
  end
end
