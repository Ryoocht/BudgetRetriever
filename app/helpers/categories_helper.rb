module CategoriesHelper
    def idToCategoryName(id)
        category = Category.find_by(id: id)
        category.name
    end

    def getChildCategories(id)
        children = Category.find_by(id: id).children
        children
    end
    
    def category_color(name)
        case name
        when "Expense"
            "expense-color"
        when "Income"
            "income-color"
        when "Saving"
            "saving-color"
        else
            "non-color"
        end
    end
end
