require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'blackjack'

class BlackJackTest < MiniTest::Test

  attr_reader :player

  def setup
    @player = Player.new("Michael")
  end

  def test_a_player_has_a_name
    assert_equal "Michael", player.name
  end

  def test_a_game_has_a_player
    assert_equal "Michael", Game.new(player).player.name
  end

  def test_a_player_has_no_cards_at_beginning_of_game
    assert_equal [], player.cards
  end

  def test_a_player_has_two_cards_when_game_deals_cards
    game = Game.new(player)
    game.deal
    assert_equal 2, player.cards.count
    refute_equal player.cards[0], player.cards[1]
  end

  def test_game_builds_deck
    game = Game.new(player)
    assert_equal 52, game.build_deck.count
  end

  def test_the_player_has_a_score
    player.cards << Card.new("9", "Clubs")
    player.cards << Card.new("10", "Diamonds")
    assert_equal 19, player.score
  end

  def test_the_player_has_a_score_even_with_aces
    player.cards << Card.new("9", "Clubs")
    player.cards << Card.new("A", "Diamonds")
    assert_equal 10 || 20, player.score
  end

  def test_the_hit_method_adds_cards_to_players_hand
    game = Game.new(player)
    game.deal
    assert_equal 2, player.cards.count
    game.hit
    assert_equal 3, player.cards.count
  end

  def test_the_score_cannot_go_over_twenty_one
    player.cards << Card.new("10", "Clubs")
    player.cards << Card.new("10", "Diamonds")
    player.cards << Card.new("5", "Diamonds")
    assert_equal "Bust", player.score
  end

  def test_twenty_one_returns_blackjack
    player.cards << Card.new("9", "Clubs")
    player.cards << Card.new("2", "Diamonds")
    player.cards << Card.new("10", "Diamonds")
    assert_equal "BlackJack", player.score
  end

  def test_player_has_bet
    assert_equal 0, player.current_bet
  end

  def test_player_can_add_a_bet
    assert_equal 100, player.bet(100)
  end

  def test_the_player_cannot_bet_if_score_is_greater_than_or_equal_to_21
    player.cards << Card.new("9", "Clubs")
    player.cards << Card.new("2", "Diamonds")
    player.cards << Card.new("10", "Diamonds")
    assert_equal "You already have BlackJack", player.bet(500)
  end

end