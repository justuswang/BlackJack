def calculate_total(cards)
  num_ace = 0
  total = 0
  cards.each do |card|
    card_value = card[1]
    if card_value == 'A'
      v = 1
      num_ace += 1
    elsif card_value.to_i == 0
      v = 10
    else
      v = card_value.to_i
    end
    total += v
  end

  num_ace.times do
    total += 10 if total + 10 <= 21
  end
  total
end

def get_cards_in_hand(cards)
  card_names = []
  cards.each do |card|
    card_names.push "#{card[0]} #{card[1]}"
  end

  card_names.join(', ')
end

def init_deck
  suits = ['Heart', 'Diamond', 'Spade', 'Club']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  suits.product(cards).shuffle!
end

puts 'Please enter your name:'
player = gets.chomp
puts "Hi #{player}! Welcome to BlackJack game!"

first_time = true
while true
  if first_time
    first_time = false
  else
    puts 'Play again? (Y/N)'
    exit if gets.chomp.upcase == 'N'
  end

  deck = init_deck

  player_cards = []
  dealer_cards = []
  dealer_total = 0

  player_cards.push deck.pop
  dealer_cards.push deck.pop
  player_cards.push deck.pop
  dealer_cards.push deck.pop

  while deck.length > 0
    player_total = calculate_total(player_cards)
    puts "You have #{get_cards_in_hand(player_cards)}, total is #{player_total}."

    if player_total == 21
      puts 'You Win!'
      break
    elsif player_total > 21
      puts 'You Busted!'
      break
    else
      puts 'Hit or stay? (hit/stay)'
    end

    if gets.chomp.upcase == 'HIT'
      player_cards.push deck.pop
      next
    end

    dealer_total = calculate_total(dealer_cards)
    puts "Dealer has #{get_cards_in_hand(dealer_cards)}, total is #{dealer_total}."
    while dealer_total < 17
      new_card = deck.pop
      dealer_cards.push new_card
      dealer_total = calculate_total(dealer_cards)
      puts "Dealing card #{new_card.join(' ')} for dealer..., total is #{dealer_total}."
    end

    dealer_total = calculate_total(dealer_cards)
    puts "You have #{get_cards_in_hand(player_cards)}, total is #{player_total}."
    puts "Dealer has #{get_cards_in_hand(dealer_cards)}, total is #{dealer_total}."

    if dealer_total == 21 || (dealer_total < 21 && dealer_total > player_total)
      puts 'Dealer Win!'
    elsif dealer_total < 21 && dealer_total < player_total
      puts 'You Win!'
    elsif dealer_total < 21 && dealer_total == player_total
      puts 'It\'s a tie!'
    else
      puts 'You Win! Dealer busted!'
    end
    break
  end
end
