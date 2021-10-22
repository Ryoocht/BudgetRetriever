
# def make_seeds
#     make_categories
# end

# def make_categories
   
# end

main = Category.create(name: "Expense")

food = main.children.create(name: "Food")
shopping = main.children.create(name: "Shopping")

food.children.create([{name: "Groceries"}, {name: "Restaurant/Cafe"}, {name: "Fast Food/TA"}, {name: "Food Delivery"}, {name: "Servo/Snack"}])
shopping.children.create([{name: "Clothes"}, {name: "Shoes"}, {name: "Bag"}, {name: "Jewellery"}, {name: "Homewares"}, {name: "Tech"}, {name: "Toiletries"}, {name: "Others"}])


# Bill.create(user_id: 1, month: "October", year: 2021, category_id: 1, subcategory_id: 1, further_subcategory_id: 1, price: 35.0, detail: "take away")