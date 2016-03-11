require_relative 'hand'
require_relative 'deck'
require_relative 'card'
require_relative 'player'
require 'byebug'
class Game
  attr_reader :deck, :current_player, :other_player

  def initialize
    @deck = Deck.new
    @current_player = Player.new("John", Hand.new(deck))
    @other_player = Player.new("Bob", Hand.new(deck))
  end

  def play

    until current_player.hand.cards.empty? || other_player.hand.cards.empty?
      card_choice = ask_choice

      if other_player.hand.has_card?(card_choice)
        give_card(card_choice)
        handle_books(new_card)
      else
        doesnt_have_card(card_choice)
        current_player.go_fish(deck)

        handle_books(new_card)

        switch_players
      end
    end

    if winner.is_a?(Player)
      puts "Winner is #{winner.name} with #{winner.book_count} books!"
    else
      puts "We have a good old fashion tie"
    end
  end

  def winner
    case current_player.book_count <=> other_player.book_count
    when 1
      current_player
    when -1
      other_player
    end
  end

  def give_card(card_choice)
    given_cards = other_player.hand.give_cards(card_choice)
    current_player.hand.recieve_cards(given_cards)
    puts "Other player has given you #{card_choice}(s)"
  end

  def doesnt_have_card(card_choice)
    puts "#{other_player.name} did not have #{card_choice}"
    puts "Go Fish"
  end

  def ask_choice
    puts "#{current_player.name} you have #{current_player.book_count} book(s) "
    puts "#{current_player.name} your cards are #{current_player.display_hand}"
    begin
      puts "What card would you like?"
      choice = gets.chomp
      validates_choice(choice)
    rescue
      puts "You can only ask for a card that you have"
      retry
    end
    choice
  end

  def validates_choice(choice)
    hand_values = current_player.hand.cards.map(&:value)

    unless hand_values.include?(choice)
      raise "Invalid" if card.value != choice
    end
  end

  def handle_books(card_choice)
    if current_player.hand.has_book?
      current_player.book_count += 1
      current_player.hand.drop_book
      puts "#{current_player.name} has dropped his book of #{card_choice.value}s "
    end
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  private

  def new_card
    current_player.hand.cards.last
  end

end

Game.new.play
