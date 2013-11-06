class Card
  attr_accessor :suit, :value

  def initialize(s, v)
    @suit = s
    @value = v
  end

  def to_s
    "#{suit} #{value}"
  end
end

class Deck
  attr_accessor :cards

  def initialize(num_decks)
    @cards = []
    ['Heart', 'Diamond', 'Spade', 'Club'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |value|
        @cards.push Card.new(suit, value)
      end
    end
    @cards = @cards * num_decks
    @cards.shuffle!
  end

  def deal
    cards.pop
  end

  def num_cards
    cards.size
  end
end

module Hand
  def total
    tmp_total = 0
    hand_cards.each do |card|
      if card.value == 'A'
        tmp_total += 1
      elsif card.value.to_i == 0
        tmp_total += 10
      else
        tmp_total += card.value.to_i
      end
    end

    hand_cards.select { |card| card.value == 'A' }.count.times do
      tmp_total += 10 if tmp_total + 10 <= 21
    end
    tmp_total
  end

  def cards_in_hand
    hand_cards.join(', ')
  end

  def hit(card)
    hand_cards.push card
  end
end

class Dealer
  attr_accessor :name, :hand_cards

  include Hand

  def initialize
    @name = 'Dealer'
    @hand_cards = []
  end
end

class Player
  attr_accessor :name, :hand_cards

  include Hand

  def initialize(name)
    @name = name
    puts "Welcome Player #{name}!"
    @hand_cards = []
  end
end

class BlackJack
  attr_accessor :player, :dealer, :deck

  def initialize(name)
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new(1)
  end

  def run
    deal_cards
    player_turn(player)
    if player.total < 21
      dealer_turn
    end
    who_won?
  end

  private

  def deal_cards
    player.hit(deck.deal)
    dealer.hit(deck.deal)
    player.hit(deck.deal)
    dealer.hit(deck.deal)
  end

  def player_turn(player)
    while true
      puts "#{player.name} has #{player.cards_in_hand}, total is #{player.total}"
      break if player.total >= 21

      puts "#{player.name}, hit or stay? (Enter anything to stay, 'H' or 'h' to hit.)"

      break unless gets.chomp.upcase == 'H'
      player.hit(deck.deal)
    end
  end

  def dealer_turn
    while true
      puts "#{dealer.name} has #{dealer.cards_in_hand}, total is #{dealer.total}"
      break if dealer.total >= 21

      break unless dealer.total < 17
      dealer.hit(deck.deal)
    end
  end

  def who_won?
    if player.total == 21
      puts "#{player.name} win!"
    elsif player.total > 21
      puts "#{player.name} busted!"
      puts "#{dealer.name} win!"
    elsif dealer.total == 21
      puts "#{dealer.name} win!"
    elsif dealer.total > 21
      puts "#{dealer.name} busted!"
      puts "#{player.name} win!"
    elsif dealer.total > player.total
      puts "#{dealer.name} win!"
    elsif dealer.total < player.total
      puts "#{player.name} win!"
    elsif dealer.total == player.total
      puts 'It\'s a tie!'
    end
  end
end

puts 'Please enter your name:'
name = gets.chomp

first_time = true
while true
  if first_time
    first_time = false
  else
    puts 'Play again? (Enter anything to to play again, \'N\' or \'n\' to exit.)'
    exit if gets.chomp.upcase == 'N'
  end
  BlackJack.new(name).run
end

