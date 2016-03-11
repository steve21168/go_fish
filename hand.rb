class Hand
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

  #Gives an array of any cards that is has and removes from own hand
  def give_cards(card_value)
    raise "Doesn't have the card" unless has_card?(card_value)

    give_arr = cards.select { |card_obj| card_obj.value == card_value }
    cards.delete_if { |card_obj| card_obj.value == give_arr[0].value }

    give_arr
  end

  #Recieve cards array
  def recieve_cards(cards_arr)
    cards_arr.each do |card_obj|
      self.cards << card_obj
    end
  end

  def has_book?
    card_count = books_hash

    card_count.values.any? { |values| values == 4 }
  end

  def drop_book
    card_count = books_hash

    book_val = card_count.key(4)

    cards.delete_if { |card| card.value == book_val }
  end

  private

  def books_hash
    card_count = Hash.new(0)

    cards.each do |card_obj|
      card_count[card_obj.value] += 1
    end
    card_count
  end

end
