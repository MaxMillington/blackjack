require 'pry'

class Player

  attr_reader :name, :cards, :current_bet

  def initialize(name)
    @name = name
    @cards = []
    @current_bet = 0
  end

  def score
    values = {
        '2' => 2, '3' => 3, '4' => 4,  '5' => 5, '6' => 6,
        '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10,
        'Q' => 10, 'K' => 10,
        'A' => 1 || 11
    }
    number = cards.reduce(0) do |total, card|
      total += values[card.rank]
    end

    if number > 21
      "Bust"
    elsif number == 21
      "BlackJack"
    else
      number
    end
  end

  def bet(amount)
    if score == "Bust"
      "You aleady busted out"
    elsif score == "BlackJack"
      "You already have BlackJack"
    else
      @current_bet += amount
    end
  end

end

class Card

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

end


class Game

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def build_deck
    stack_of_cards = []
    ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
    suits = %w{Spades Hearts Diamonds Clubs}
    suits.each do |suit|
      ranks.size.times do |i|
        stack_of_cards << Card.new(ranks[i], suit)
      end
    end
    stack_of_cards
  end

  def deal
    player.cards << build_deck.shuffle.pop
    player.cards << build_deck.shuffle.pop
  end

  def hit
    player.cards << build_deck.shuffle.pop
  end

end