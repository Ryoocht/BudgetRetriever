class BillsController < ApplicationController
    before_action :set_category, only: [:index]

    def index
        @bills = Bill.all
        @bill = Bill.new
        @months = Month.all 
    end

    def new
        @category_parent_array = ["---"]
        Category.where(ancestry: nil).each do |parent|
            @category_parent_array << parent.name
        end
    end

    def get_category_children
        @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    end

    def get_category_grandchildren
        @category_grandchildren = Category.find("#{params[:child_id]}").children
    end

    private

    def set_category
        @category_parent_array = Category.where(ancestry: nil)
    end
end
