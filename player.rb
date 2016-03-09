class Player

###Book count?
###

  attr_accessor :book_count
  attr_reader :hand, :name

  def initialize(name, hand)
    @name = name
    @hand = hand
    @book_count = 0
  end

  def display_hand
    hand.cards.map(&:to_s)
  end

end
