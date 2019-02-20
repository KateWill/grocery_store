Taxes = 0.047
@my_cart = []
@purchase_history = []
@wallet = {amount: 5.00}
@store_items = [
  {item:'apple', price: 0.99 },
  {item: 'orange', price: 0.79 },
  {item: 'pear', price: 0.49 },
  {item: 'avocado', price: 2.00 },
  {item: 'strawberries', price: 0.89 },
  {item: 'milk', price: 1.50 }
]

def menu
  puts
  puts "Make a selection:"
  puts
  puts '1)  View grocery items'
  puts '2)  Add to cart'
  puts '3)  View cart'
  puts '4)  Remove from cart'
  puts '5)  Show cart total'
  puts '6)  Add to store'
  puts '7)  View your wallet'
  puts '8)  Check out'
  puts '9)  View purchase history'
  puts '10) Exit'
end

def user_selection
  menu
  choice = gets.to_i
  case choice
  when 1
    view_grocery_store
  when 2
    add_to_cart
  when 3
    view_cart
  when 4
    remove_from_cart
  when 5
    show_total
  when 6
    add_to_store
  when 7 
    view_user_wallet
  when 8
    check_out
  when 9 
    view_purchase_history
  when 10
    puts "Goodbye!"
    exit
  else
    puts 'Error: invalid choice, please try again.'
  end

   user_selection
end


def view_grocery_store
  puts
  @store_items.each_with_index { |item, index| 
  puts "#{index + 1}) #{item[:item]} $#{item[:price]}"
}
  puts 
end

def add_to_cart
  puts 'What do you want to add to your cart?' 
  view_grocery_store
  choice = gets.to_i
    if choice > 0 && choice <= @store_items.count
    item = @store_items[choice - 1][:item]
    price =  @store_items[choice - 1][:price]
    puts "You added: #{item} $#{price}"
    puts  
    @my_cart << { item: item , price: price } 
    end
end

def view_cart
  puts "Items in your cart:"
  puts
  if @my_cart.length > 0 
  @my_cart.each_with_index { |item, index| 
  puts "#{index + 1}) #{item[:item]} $#{item[:price]}" 
  }
  puts
  else
    puts
    puts "*There are currently no items in your cart."
  end
end

def remove_from_cart
  if @my_cart.length > 0
    puts
    puts "What do you want to remove?"
    puts
    view_cart
    choice = gets.to_i
    item = @my_cart[choice - 1][:item]
    price =  @my_cart[choice - 1][:price]
    
    puts "You removed: #{choice}) #{item} $#{price}" 
    
    if choice > 0 && choice <= @my_cart.count
      
      to_delete = @my_cart
      to_delete.delete_at(choice - 1)     
    end
    puts
    puts "Remove another item? (y/n)"
    another = gets.to_s
    # p another
    if another.chomp == "y"
      remove_from_cart
    elsif another.chomp == "n"
    
    else
      puts "Error: Invalid input, please try again."
    end
  else
    puts "Currently there are no items in your cart."
  end
end

def calc_total
  total = 0.00
  # pre tax amount
  @my_cart.each_with_index { |item, index| total += item[:price]}
  pre_tax = total
  post_tax = (total * Taxes).round(2)
  total += post_tax
  return total.round(2), post_tax, pre_tax
  
end

def show_total
  puts
  puts "Your total is:"
  puts
  # display items in cart
  @my_cart.each_with_index { |item, index| 
  puts "#{index + 1}) #{item[:item]} #{item[:price]}" 
  }
  price = calc_total
  # p calc_total
  puts
  puts "Cost: $#{price[2]}"
  puts "Tax: $#{price[1]} "
  puts "Total: $#{price[0]}"
  
end

def add_to_store
  puts 'What do you want to add to the store?' 
    to_add_item = gets.to_s
  puts 'How much should this item cost?'
    to_add_price = gets.to_f
    
  @store_items << { item: to_add_item.chomp, price: to_add_price }
  puts "You added: #{to_add_item.chomp} $#{to_add_price}"
  puts    
end

def user_wallet_calc(updated_wallet_amount)
  # p updated_wallet_amount
  @wallet[:amount] += updated_wallet_amount
end

def view_user_wallet
  puts "You have $#{user_wallet_calc(0).round(2)} in your wallet."
end

def check_out
  price = calc_total

  puts "Your Total is: $#{price[0]}"
  puts "checking out..."
  # p user_wallet

  if user_wallet_calc(0) > price[0]
    updated_wallet_amount = user_wallet_calc(0) - price[0]
    puts "You have $#{updated_wallet_amount.round(2)} left in your wallet."
    @wallet[:amount] = updated_wallet_amount
    @my_cart.each { |item| @purchase_history << item }
    @my_cart.clear
    
  else
    puts "Not enough money in wallet, please delete items."
    remove_from_cart
    check_out
  end
end

def view_purchase_history
  puts "Purchase History: "
  # p @my_cart
  # p @purchase_history
  if @purchase_history.length > 0 
    @purchase_history.each_with_index { |item, index|
    # p "item is: #{item}"
    puts "#{index + 1}) #{item[:item]} $#{item[:price]}"
      # item.each_with_index { |level2, index |
      #  p "#{index + 1}) #{level2[:item]} $#{level2[:price]}"
      # # p "l"
      # }
    }
    puts
    else
      puts
      puts "*There are currently no items in your purchase history."
    end
end

user_selection