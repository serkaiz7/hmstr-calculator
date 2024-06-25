#!/bin/bash

# Function to calculate and display profit comparison
calculate_profit() {
    declare -A companies
    declare -A profits
    max_profit=0

    while true; do
        read -p "Enter company name (or type 'done' to finish): " company
        if [ "$company" == "done" ]; then
            break
        fi
        
        read -p "Enter coin price for $company: " coin_price
        read -p "Enter profit per hour for $company: " profit_per_hour
        
        # Calculate total profit
        profit=$(echo "$coin_price * $profit_per_hour" | bc)
        companies["$company"]=$profit
        
        # Track the maximum profit for percentage calculation
        if (( $(echo "$profit > $max_profit" | bc -l) )); then
            max_profit=$profit
        fi
    done

    # Display profits and calculate differences
    echo -e "\nProfit Comparison:"
    for company in "${!companies[@]}"; do
        profit=${companies[$company]}
        percentage=$(echo "scale=2; ($profit / $max_profit) * 100" | bc)
        bar=$(printf "%0.s#" $(seq 1 $(echo "$percentage / 10" | bc)))
        echo "$company: \$${profit} (${percentage}%) |$bar"
    done

    echo -e "\nProfit Differences:"
    for company1 in "${!companies[@]}"; do
        for company2 in "${!companies[@]}"; do
            if [ "$company1" != "$company2" ]; then
                profit1=${companies[$company1]}
                profit2=${companies[$company2]}
                difference=$(echo "$profit1 - $profit2" | bc)
                echo "Difference between $company1 and $company2: \$${difference}"
            fi
        done
    done
}

calculate_profit
