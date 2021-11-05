def make_seeds
    make_accounts
    make_categories
    make_months
    # make_bills
end

def make_accounts
    ["Personal", "Business", "Familly", "Joint Bills", "Credit Bills"].each {|account| Account.create(name: account)}
end

def make_categories
    expense_child_array = ["Food", "Shopping", "Housing", "Transportation", "Travel", "Utilities", "Personal", "Entertainment", "Medical", "Gym", "Insurance", "Debt", "Education", "Gift", "Investment", "Others"]
    expense_grandchild_array = [["Groceries", "Restaurant/Cafe", "Fast Food/TA", "Food Delivery ", "Servo/Snack"], ["Clothes", "Shoes", "Bag", "Jewellery", "Homewares/Furniture", "Tech", "Toiletries/Makeup", "Others"], ["Mortgage", "Rates", "Body Corp", "Household Repairs"], ["Petrol", "Parking Fees", "Auto Maintenance", "Rego", "Taxi"], ["Flights", "Visa", "Passport", "Accomodation", "Cash", "Transport"], ["Electricity", "Water", "Phones", "Internet"], ["Haircuts", "Massage"], ["Alcohol/Bars", "Games", "Movies", "Concerts", "Subscriptions", "Gambling"], ["GP", "Dentist", "Specialist", "Urgent Care", "Medications"], ["Membership", "Supplement"], ["Health Insurance", "Contents Insurance", "Car Insurance", "Travel Insurance"], ["Personal Loans", "Credit Cards"], ["Books", "Classes"], ["Birthday", "Anniversary", "Wedding", "Christmas", "Special occasion", "Charities"], ["Shares", "Cryptocurrency"], ["Postage", "Shipping Fees", "Others"]]
    income_child_array = ["Work", "Sales", "Investment", "Misc"]
    income_grandchild_array = [["Paycheck", "Bonus", "Tax Return"], ["Ebay/FB", "Purchase Refund"], ["Dividends", "Shares", "Cryptocurrency"], ["Present", "Lottery/Gambling"]]
    saving_child_array = ["Monthly Savings"]
    saving_grandchild_array = [["Saving"]]

    expense = Category.create(name: "Expense")
    expense_child_array.each_with_index do |child, i|
        child = expense.children.create(name: child)
        expense_grandchild_array[i].each do |grandchild|
            child.children.create(name: grandchild)
        end
    end

    income = Category.create(name: "Income")
    income_child_array.each_with_index do |child, i|
        child = income.children.create(name: child)
        income_grandchild_array[i].each do |grandchild|
            child.children.create(name: grandchild)
        end
    end

    saving = Category.create(name: "Saving")
    saving_child_array.each_with_index do |child, i|
        child = saving.children.create(name: child)
        saving_grandchild_array[i].each do |grandchild|
            child.children.create(name: grandchild)
        end
    end
end

def make_months
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"].each {|month| Month.create!(name: month)}
end

# def make_bills
#     Bill.create(month_id: 10, year: 2021, price: 23.56, detail: "Uber", category_id: 1, subcategory_id: 22, further_subcategory_id: 27)
#     Bill.create(month_id: 10, year: 2021, price: 25.00, detail: "Haircut", category_id: 1, subcategory_id: 40, further_subcategory_id: 41)
#     Bill.create(month_id: 10, year: 2021, price: 34.56, detail: "Protain Powder", category_id: 1, subcategory_id: 56, further_subcategory_id: 58)
#     Bill.create(month_id: 10, year: 2021, price: 56.70, detail: "Woolies", category_id: 1, subcategory_id: 2, further_subcategory_id: 3)
# end

make_seeds