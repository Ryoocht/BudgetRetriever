class CategoriesController < ApplicationController
    before_action :set_category, only: [:index]

    def index
    end

    def get_category_children
        @category_children = Category.find(params[:category_id]).children
    end

    def get_category_grandchildren
        @category_grandchildren = Category.find(params[:category_id]).children
    end

    private

    def set_category
        @category_parent_array = Category.where(ancestry: nil)
    end
end
