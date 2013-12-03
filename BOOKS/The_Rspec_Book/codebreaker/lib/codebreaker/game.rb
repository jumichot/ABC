module Codebreaker
  class Game
    def initialize output
      @output = output
    end

    def start(secret)
      @secret = secret
      @output.puts("Welcome to Codebreaker!")
      @output.puts("Enter a guess:")
    end

    def guess guess
      mark = ''
      (0..3).each do |index|
        if exact_match? guess, index 
          mark << "+"
        elsif number_match? guess, index
          mark << "-"
        end
      end
      @output.puts mark.split(//).sort.join
    end

    def number_match? guess, index
      @secret.include?(guess[index])
    end

    def exact_match? guess, index
      @secret[index] == guess[index]
    end
  end
end
