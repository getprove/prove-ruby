require 'prove'
describe Prove::Client do
  it "should be initializable" do
    expect(Prove::Client.new).to_not be_nil
  end

  it "should have an env variable with secret key" do
    expect(ENV['PROVE']).to_not be_nil
  end 
end
