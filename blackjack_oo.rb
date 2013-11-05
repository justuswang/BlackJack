class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{suit} #{value}"
  end
end

class Deck
  def initialize
    @cards = []
    ['Heart', 'Diamond', 'Spade', 'Club'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |value|
        @cards.push Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end

  def deal
    if @cards.length > 0
      @cards.pop
    else
      puts 'No card left'
      nil
    end
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @hand_cards = []
    @total = 0
  end

  def hit(card)
    @hand_cards.push card
  end

  def total
    total = 0
    @hand_cards.each do |card|
      if card.value == 'A'
        total += 1
      elsif card.value.to_i == 0
        total += 10
      else
        total += card.value.to_i
      end
    end

    @hand_cards.select { |card| card.value == 'A' }.count.times do
      total += 10 if @total + 10 <= 21
    end
    @total = total
  end

  def cards_in_hand
    @hand_cards.join(', ')
  end

  def busted?
    @total > 21
  end

  def win?
    @total == 21
  end

  def gap
    (@total - 21).abs
  end
end

p1 = Player.new('test1')
p2 = Player.new('dealer')

puts p1.name
puts p2.name

deck = Deck.new

p1.hit(deck.deal)
puts "#{p1.name}: #{p1.cards_in_hand}"
puts "#{p1.name}: #{p1.total}"
puts "#{p1.name}: #{p1.busted?}"
puts "#{p1.name}: #{p1.win?}"
puts "#{p1.name}: #{p1.gap}"

p2.hit(deck.deal)
puts "#{p2.name}: #{p2.cards_in_hand}"
puts "#{p2.name}: #{p2.total}"
puts "#{p2.name}: #{p2.busted?}"
puts "#{p2.name}: #{p2.win?}"
puts "#{p2.name}: #{p2.gap}"

p1.hit(deck.deal)
puts "#{p1.name}: #{p1.cards_in_hand}"
puts "#{p1.name}: #{p1.total}"
puts "#{p1.name}: #{p1.busted?}"
puts "#{p1.name}: #{p1.win?}"
puts "#{p1.name}: #{p1.gap}"

p2.hit(deck.deal)
puts "#{p2.name}: #{p2.cards_in_hand}"
puts "#{p2.name}: #{p2.total}"
puts "#{p2.name}: #{p2.busted?}"
puts "#{p2.name}: #{p2.win?}"
puts "#{p2.name}: #{p2.gap}"
