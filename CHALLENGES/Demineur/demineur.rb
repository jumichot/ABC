require "minitest/autorun"

class Demineur
end

class DemineurTest < MiniTest::Unit::TestCase
  def setup
   @demineur = Demineur.new(board_width: 10, bomb_count: 4)
  end

  def test_that_it_has_a_board
    assert_equal "o o o o o o o o o o", @demineur.display_board
  end
end
