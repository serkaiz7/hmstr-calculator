# Profit Calculator

This script allows you to input the coin price and profit per hour for multiple companies, then calculates and compares their profitability. The output includes the difference between the profits of all given companies and an ASCII representation of profitability.

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/profit-calculator.git
    cd profit-calculator
    ```

2. Make the script executable:
    ```bash
    chmod +x profit_calculator.sh
    ```

3. Run the script:
    ```bash
    ./profit_calculator.sh
    ```

4. Follow the prompts to input the company data.

## Example

```bash
Enter company name (or type 'done' to finish): CompanyA
Enter coin price for CompanyA: 10
Enter profit per hour for CompanyA: 2
Enter company name (or type 'done' to finish): CompanyB
Enter coin price for CompanyB: 15
Enter profit per hour for CompanyB: 1.5
Enter company name (or type 'done' to finish): done

Profit Comparison:
CompanyA: $20.00 (100%) |##########
CompanyB: $22.50 (112.50%) |############

Profit Differences:
Difference between CompanyA and CompanyB: -$2.50
Difference between CompanyB and CompanyA: $2.50
