# BudgetRetriever
## Details about Budget Retriever
Check out my blog writting about this project and a bit of the details
URL: https://medium.com/@Ryoocht/ruby-on-rails-project-budget-retriever-frontend-backend-app-7b043bbe3dc

## Ruby version
ruby 3.0.0

## Configurations
Database: PostgreSQL
Added Gems: Omniauth(Facebook, Google), dotenv-rails, ancestry, bcrypt

## Usage
To use: $ Clone this repository
step 1: $ bundle install
step 2: $ rails db:create
step 3: $ rails db:migrate
step 4: $ rails db:seed

## Features
### Authentication
Users can signup / signin / signout with a customised login form or use third-party authentication such as Facebook or Google.
### Table
Users can both create and select exist table to add bills. And you can have as many tables as you want.
### Bill
Usage of Bill page is to see all records or create / edit / delete bills.
if you create a bill you need to fill all of input fields besides details input field, otherwise validation errors will be occured.
#### validations
* Month: select from the dropdown options
* Year: value between 2020 to 2050
* Main Category: select from the dropdown options (once you select main category subcategory input will be appeared.)
* Subcategory: select from the dropdown options (once you select main category subcategory input will be appeared.)
* Further Subcategory: select from the dropdown options
* Price: only number is available (no letter or symbol)
* Detail: optional, you can add anything.
### Category
Users can also modify the category table. If you want to add subcategory or further subcategory, make sure that you specify its parent category.
If you want to edit or delete some categories, simpley click a title of category from edit or delte table.
### Total
Users can see their total budget status by clicking total table button.
Your bill records will be broken down into further subcategory and sum up the total price by bill's month.