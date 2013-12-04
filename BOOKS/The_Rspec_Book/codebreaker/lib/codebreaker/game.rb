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
      mark += '+' * exact_match_count(guess) 

      (0..3).each do |index|
        if number_match? guess, index
          mark << "-"
        end
      end
      @output.puts mark.split(//).sort.join
    end

    def exact_match_count guess
      (0..3).inject(0) do |count,index|
          count + (exact_match?(guess, index)? 1 : 0)
      end
    end

    def number_match? guess, index
      @secret.include?(guess[index]) && !exact_match?(guess, index)
    end

    def exact_match? guess, index
      @secret[index] == guess[index]
    end
  end
end
