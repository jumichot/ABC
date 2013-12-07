class Marker
  def initialize secret, guess
    @guess = guess
    @secret = secret
  end

  def number_match_count
    total_match_count - exact_match_count
  end

  def total_match_count
    secret = @secret.split('')
    count = 0
    @guess.split('').map do |index|
      if secret.include?(index)
        secret.delete_at(secret.index(index))
        count += 1
      end
    end
    count
  end

  def exact_match_count
    (0..3).inject(0) do |count,index|
      count + (exact_match?(index)? 1 : 0)
    end
  end

  def number_match? index
    @secret.include?(@guess[index]) && !exact_match?(index)
  end

  def exact_match? index
    @secret[index] == @guess[index]
  end
end
