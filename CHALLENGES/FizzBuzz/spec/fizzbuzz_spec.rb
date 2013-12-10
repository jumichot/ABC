module FizzBuzz
  class Reporter
    def to_a limit
      ary = []
      (1..limit).each_with_index do |num, index|
        if (index+1)%3 == 0
          ary << "Fizz"
        else
          ary << num
        end
      end
      ary
    end
  end
end

module FizzBuzz
  describe Reporter do
    it "reports correctly the first line" do
      expect(subject.to_a(1)).to eq [1]
    end
    it "reports correctly the first 2 lines" do
      expect(subject.to_a(2)).to eq [1,2]
    end
    it "reports correctly the first 3 lines" do
      expect(subject.to_a(3)).to eq [1,2,"Fizz"]
    end
    it "reports correctly the first 4 lines" do
      expect(subject.to_a(4)).to eq [1,2,"Fizz",4]
    end
  end
end
