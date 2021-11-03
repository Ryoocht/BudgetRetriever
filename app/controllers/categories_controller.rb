class CategoriesController < ApplicationController
    before_action :set_category, only: [:index]

    def index
        @category = Category.new
    end

    def create
        exist_main_category = Category.where(ancestry: nil).pluck(:name)
        new_category_array = exist_main_category
        new_category_array << category_params[:main_category]
        if  new_category_array.uniq.length == exist_main_category.length
            #new main category
            new_category = Category.create(name: category_params[:main_category])
            #new subcategory
            if !category_params[:subcategory].nil?
                child = new_category.children.create(name: category_params[:subcategory])
                #new further subcategory
                if !category_params[:further_subcategory].nil?
                    child.children.create(name: category_params[:further_subcategory])
                end
            end
        else
            #exist main category
            parent_obj = Category.find_by(name: category_params[:main_category]).children
            exist_subcategory_array = []
            parent_obj.each{|sub| exist_subcategory_array << sub.name}
            new_subcategory_array = exist_subcategory_array
            new_subcategory_array << category_params[:subcategory]
            if  new_subcategory_array.uniq.length == exist_subcategory_array.length
               #new subcategory
                if !category_params[:subcategory].nil?
                    child = parent_obj.create(name: category_params[:subcategory])
                    #new further subcategory
                    if !category_params[:further_subcategory].nil?
                        child.children.create(name: category_params[:further_subcategory])
                    end
                end
            else
                #exist subcategory
                child_obj = Category.find_by(name: category_params[:subcategory]).children
                exist_further_subcategory_array = []
                child_obj.each{|fur| exist_further_subcategory_array << fur.name}
                new_further_subcategory_array = exist_further_subcategory_array
                new_further_subcategory_array << category_params[:further_subcategory]
                if  new_further_subcategory_array.uniq.length == exist_further_subcategory_array.length
                    #new further subcategory
                    if !category_params[:further_subcategory].nil?
                        child_obj.create(name: category_params[:further_subcategory])
                    end
                end
            end
        end
        redirect_to categories_path
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

    def category_params
        params.require(:category).permit(:main_category, :subcategory, :further_subcategory)
    end
end
