module FizzBuzz
  class Reporter
    def to_a limit
      (1..limit).to_a
    end
  end
end

module FizzBuzz
  describe Reporter do
    it "reporte correctly the first line" do
      expect(subject.to_a(1)).to eq [1]
    end

    it "reporte correctly the first line" do
      expect(subject.to_a(2)).to eq [1,2]
    end
  end
end
