#!/bin/bash

# Function to calculate and display investment comparison
calculate_investment() {
    declare -A companies
    declare -A coin_prices
    declare -A profit_per_hours
    max_profit_per_hour=0
    min_coin_price=0

    while true; do
        read -p "Enter company name (or type 'done' to finish): " company
        if [ "$company" == "done" ]; then
            break
        fi
        
        read -p "Enter coin price for $company: " coin_price
        read -p "Enter profit per hour for $company: " profit_per_hour
        
        # Store data
        companies["$company"]=$company
        coin_prices["$company"]=$coin_price
        profit_per_hours["$company"]=$profit_per_hour
        
        # Track the maximum profit per hour and minimum coin price for comparison
        if (( $(echo "$profit_per_hour > $max_profit_per_hour" | bc -l) )); then
            max_profit_per_hour=$profit_per_hour
        fi
        if (( $(echo "$min_coin_price == 0 || $coin_price < $min_coin_price" | bc -l) )); then
            min_coin_price=$coin_price
        fi
    done

    # Display investment data and calculate the best investment
    echo -e "\nInvestment Comparison:"
    for company in "${!companies[@]}"; do
        coin_price=${coin_prices[$company]}
        profit_per_hour=${profit_per_hours[$company]}
        profit_efficiency=$(echo "scale=2; $profit_per_hour / $coin_price" | bc)
        percentage=$(echo "scale=2; ($profit_efficiency / ($max_profit_per_hour / $min_coin_price)) * 100" | bc)
        bar=$(printf "%0.s#" $(seq 1 $(echo "$percentage / 10" | bc)))
        echo "$company: Coin Price: \$${coin_price}, Profit/Hour: \$${profit_per_hour} (Efficiency: ${profit_efficiency}) |$bar"
    done

    echo -e "\nBest Investment:"
    best_efficiency=0
    best_company=""
    for company in "${!companies[@]}"; do
        coin_price=${coin_prices[$company]}
        profit_per_hour=${profit_per_hours[$company]}
        profit_efficiency=$(echo "scale=2; $profit_per_hour / $coin_price" | bc)
        if (( $(echo "$profit_efficiency > $best_efficiency" | bc -l) )); then
            best_efficiency=$profit_efficiency
            best_company=$company
        fi
    done
    echo "The best company to invest in is $best_company with an efficiency of $best_efficiency (Profit/Hour per Coin Price)."
}

calculate_investment
