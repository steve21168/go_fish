require 'byebug'
require_relative 'hand'
require_relative 'deck'
require_relative 'card'
require_relative 'player'

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
        has_card(card_choice)
      else
        doesnt_have_card(card_choice)
      end

      handle_books(card_choice)
      switch_players
    end

    if winner.is_a?(Player)
      puts "Winner is #{winner.name} with #{winner.book_count} books!"
    else
      winner
    end
  end

  def winner
    case current_player.book_count <=> other_player.book_count
    when 1
      current_player
    when 0
      "We have a good old fashion tie"
    when -1
      other_player
    end
  end


  def has_card(card_choice)
    given_cards = other_player.hand.give_cards(card_choice)
    current_player.hand.recieve_cards(given_cards)
    puts "Other player has given you #{card_choice}(s)"
  end

  def doesnt_have_card(card_choice)
    puts "Other player did not have #{card_choice}"
    puts "Go Fish"
    current_player.hand.cards << deck.take
  end

  def ask_choice
    puts "#{current_player.name} You have #{current_player.book_count} books "
    puts "#{current_player.name} your cards are #{current_player.display_hand}"
    puts "What card would you like?"
    gets.chomp
  end

  def handle_books(card_choice)
    if current_player.hand.has_book?
      current_player.book_count += 1
      current_player.hand.drop_book
      puts "#{current_player.name} has dropped his book of #{card_choice} "
    end
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

end

Game.new.play
