def shuffle(array)
  shuffled = []
  while array.length > 0
    rand_index = rand(array.length)
    shuffled.push array[rand_index]
    tmp_array = []
    index = 0
    array.each do |obj|
      tmp_array.push obj unless index == rand_index
      index += 1
    end
    array = tmp_array
  end
  shuffled
end

def cal_sum(array)
  ace_exists = false
  sum = 0
  array.each do |item|
    item.each do |k, v|
      ace_exists = true if v == 1
      sum += v
    end
  end
  sum < 21 && ace_exists == true && sum + 10 <= 21 && sum += 10
  sum
end

def get_card_names(array)
  card_names = []
  array.each do |card|
    card.each do |k, v|
      card_names.push "#{k}"
    end
  end
  card_names.join(',')
end

def init_deck
  deck = [{ spade_ace: 1 }, { spade_2: 2 }, { spade_3: 3 }, { spade_4: 4 },
          { spade_5: 5 }, { spade_6: 6 }, { spade_7: 7 }, { spade_8: 8 },
          { spade_9: 9 }, { spade_10: 10 }, { spade_j: 10 }, { spade_q: 10 },
          { spade_k: 10 },
          { diamond_ace: 1 }, { diamond_2: 2 }, { diamond_3: 3 },
          { diamond_4: 4 }, { diamond_5: 5 }, { diamond_6: 6 },
          { diamond_7: 7 }, { diamond_8: 8 }, { diamond_9: 9 },
          { diamond_10: 10 }, { diamond_j: 10 }, { diamond_q: 10 },
          { diamond_k: 10 },
          { heart_ace: 1 }, { heart_2: 2 }, { heart_3: 3 }, { heart_4: 4 },
          { heart_5: 5 }, { heart_6: 6 }, { heart_7: 7 }, { heart_8: 8 },
          { heart_9: 9 }, { heart_10: 10 }, { heart_j: 10 }, { heart_q: 10 },
          { heart_k: 10 },
          { club_ace: 1 }, { club_2: 2 }, { club_3: 3 }, { club_4: 4 },
          { club_5: 5 }, { club_6: 6 }, { club_7: 7 }, { club_8: 8 },
          { club_9: 9 }, { club_10: 10 }, { club_j: 10 }, { club_q: 10 },
          { club_k: 10 }]

  shuffle deck
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

  dealer_cards = []
  dealer_sum = 0
  player_cards = []
  player_cards.push deck.pop
  player_cards.push deck.pop
  while deck.length > 0
    player_card_names = get_card_names player_cards
    puts "You have card #{player_card_names}"

    player_sum = cal_sum player_cards
    if player_sum == 21
      puts 'You Win!'
      break
    elsif player_sum > 21
      puts 'You Busted!'
      break
    else
      puts 'Hit or stay? (hit/stay)'
    end

    if gets.chomp.upcase == 'HIT'
      player_cards.push deck.pop
      next
    end

    while dealer_sum < 17
      dealer_cards.push deck.pop
      dealer_sum = cal_sum dealer_cards
    end

    dealer_card_names = get_card_names dealer_cards
    puts "Dealer has #{dealer_card_names}"
    if dealer_sum == 21 || (dealer_sum < 21 && dealer_sum > player_sum)
      puts 'Dealer Win!'
    elsif dealer_sum < 21 && dealer_sum <= player_sum
      puts  'You Win!'
    else
      puts 'You Win! Dealer busted!'
    end
    break
  end
end
