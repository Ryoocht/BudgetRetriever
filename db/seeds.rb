def make_seeds
    make_categories
    make_months
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

make_seeds