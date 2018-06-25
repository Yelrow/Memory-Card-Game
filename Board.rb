require_relative "Card.rb"

class Board
  attr_reader :board
  def initialize
    @board = Array.new(4) { Array.new(4) }
    populate
  end

  def length
    @board.length
  end

  def populate
    shuffled = self.create_cards().shuffle
    @board.length.times do |i|
      @board.length.times do |j|
        @board[i][j] = shuffled.pop
      end
    end

  end

  def create_cards
    cards = []
    8.times do |i|
      cards << Card.new(i)
      cards << Card.new(i)
    end
    cards
  end

  def render
    @board.length.times do |i|
      @board.length.times do |j|
        print @board[i][j].to_s + " "
      end
      puts ""
    end
  end

  def won?
    @board.all? do |row|
      row.all? {|card| card.visible}
    end
  end

  def [](pos)
    @board[pos[0]][pos[1]]
  end

  def reveal(pos)
    self[pos].reveal
    self[pos]
  end

end

if __FILE__ == $PROGRAM_NAME
  new_board = Board.new()
  new_board.won?
end
