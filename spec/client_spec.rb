require 'prove'
describe Prove::Client do
  it "should be initializable" do
    expect(Prove::Client.new).to_not be_nil
  end
end
