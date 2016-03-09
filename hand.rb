require 'byebug'

class Hand

# Hand should have a give card =>
# check if hand has a certain card
# check if hand has a book
# Hand should initialize with 5 cards?
#

  attr_accessor :cards

  def initialize(deck)
    @cards = deck.deal_hand
  end

  def has_card?(card_val)
    cards.each do |card_obj|
      return true if card_obj.value == card_val
    end

    false
  end


  ###Checks if player has a book and then drops the book
  def has_book?
    card_count = Hash.new(0)

    cards.each do |card_obj|
      card_count[card_obj.value] += 1
    end

    card_count.values.any? { |values| values == 4 }
  end

  def drop_book
    card_count = Hash.new(0)

    cards.each do |card_obj|
      card_count[card_obj.value] += 1
    end

    book_val = nil
    card_count.each do |card_val, count|
      if count == 4
        book_val = card_val
        break
      end
    end

    cards.delete_if { |card| card.value == book_val }
  end


  ###Gives an array of any cards that is has
  def give_cards(card_value)
    raise "Doesn't have the card" unless has_card?(card_value)

    give_arr = cards.select { |card_obj| card_obj.value == card_value }

    cards.delete_if { |card_obj| card_obj.value == give_arr[0].value }

    give_arr
  end

  ##recieve cards array
  def recieve_cards(cards_arr)
    cards_arr.each do |card_obj|
      self.cards << card_obj
    end
  end

  def to_s
    " Suit: #{@suit} Value: #{value} "
  end

  def inspect
    " Suit: #{@suit} Value: #{value} "
  end

end
