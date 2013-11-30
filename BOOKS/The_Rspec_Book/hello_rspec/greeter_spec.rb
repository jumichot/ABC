describe "RSpec greeter" do 
  it "say 'Hello Rspec! when it receive the greet() message" do
    greeter = RspecGreeter.new
    greeting = greeter.greet
    expect(greeting).to eq "Hello Rspec!"
  end
end
