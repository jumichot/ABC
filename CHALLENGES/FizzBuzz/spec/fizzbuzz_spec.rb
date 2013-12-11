module FizzBuzz
  class Finder
    def to_a limit
      (1..limit).map {|num| find(num) } 
    end

    def find num
      if (num)%3 == 0
        "Fizz"
      elsif (num)%5 == 0
        "Buzz"
      else
        num
      end
    end
  end
end

module FizzBuzz
  describe Finder do
    describe "#to_a" do
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
      it "reports correctly the first 5 lines" do
        expect(subject.to_a(5)).to eq [1,2,"Fizz",4,"Buzz"]
      end
      it "reports correctly the first 6 lines" do
        expect(subject.to_a(14)).to eq [1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz",11,"Fizz",13,14]
      end
    end
  end
end
