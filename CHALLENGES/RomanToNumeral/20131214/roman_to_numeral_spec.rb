class RomanToNumeral
  def convert num
    return "V"+convert(num-5) if num >= 5
    return "IV" if num == 4
    "I"*num
  end
end

describe RomanToNumeral do
  it "#convert 1" do
    expect(subject.convert(1)).to eq "I"
  end
  it "#convert 2" do
    expect(subject.convert(2)).to eq "II"
  end
  it "#convert 4" do
    expect(subject.convert(4)).to eq "IV"
  end
  it "#convert 5" do
    expect(subject.convert(5)).to eq "V"
  end
  it "#convert 6" do
    expect(subject.convert(6)).to eq "VI"
  end
  it "#convert 8" do
    expect(subject.convert(8)).to eq "VIII"
  end
end
