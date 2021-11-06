module CategoriesHelper
    def idToCategoryName(id)
        category = Category.find_by(id: id)
        category.name
    end

    def getChildCategories(id)
        children = Category.find_by(id: id).children
        children
    end
end
