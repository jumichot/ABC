module FizzBuzz
  class Finder
    @@special_num = {3 => "Fizz", 5 => "Buzz"}

    def to_a limit
      (1..limit).map {|num| find(num) } 
    end

    def find num
      if modulo_equal_rezo? num,3
        @@special_num[3]
      elsif modulo_equal_rezo? num,5
        @@special_num[5]
      else
        num
      end
    end

    def special_char? num
      @@special_num.keys.include? num
    end

    def modulo_equal_rezo? num, modulo
      (num)%modulo == 0
    end
  end
end

module FizzBuzz
  describe Finder do
    describe "#find" do
      it "find 1" do
        expect(subject.find(1)).to eq 1
      end
      it "find 2" do
        expect(subject.find(2)).to eq 2
      end
      it "find Fizz for 3" do
        expect(subject.find(3)).to eq "Fizz"
      end
      it "find 4" do
        expect(subject.find(4)).to eq 4
      end
    end

    describe "#special_char?" do
      it "find 3 as special char" do
        expect(subject.special_char? 3).to be_true
      end
      it "find 1 as not special char" do
        expect(subject.special_char? 1).to be_false
      end
    end

    describe "#to_a" do
      it "reports correctly the first 5 lines" do
        expect(subject.to_a(5)).to eq [1,2,"Fizz",4,"Buzz"]
      end
      it "reports correctly the first 6 lines" do
        expect(subject.to_a(14)).to eq [1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz",11,"Fizz",13,14]
      end
    end
  end
end
