module CategoriesHelper
    def idToCategoryName(id)
        category = Category.find(id)
        category.name
    end
end
