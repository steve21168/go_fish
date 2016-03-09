require_relative 'card'

class Deck

  def self.all_cards
    full_deck = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        full_deck << Card.new(suit, value)
      end
    end

    full_deck.shuffle
  end

  attr_accessor :cards

  def initialize
    @cards = Deck.all_cards
  end

  ###Go_fish means to take a card from the deck
  def take
    raise "not enough cards" if cards.count == 0
    @cards.shift
  end

  def count
    cards.count
  end

  def deal_hand
    cards_arr = []
    5.times { cards_arr << self.take }
    cards_arr
  end
end
