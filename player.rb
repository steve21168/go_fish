require 'byebug'
class Player
  attr_accessor :book_count
  attr_reader :hand, :name

  def initialize(name, hand)
    @name = name
    @hand = hand
    @book_count = 0
  end

  def go_fish(deck)
    @hand.cards << deck.take
  end

  def display_hand
    hand.cards.map(&:to_s).join(", ")
  end
end
