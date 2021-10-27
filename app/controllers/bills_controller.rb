class BillsController < ApplicationController
    before_action :set_category, only: [:new]
    before_action :set_bill, only: [:show, :edit, :update, :destroy]

    def index
        @bills = Bill.all
    end

    def show
        
    end

    def new
        @bill = Bill.new
        @months = Month.all
    end

    def create
        puts "parameter: #{params}"
        @bill = Bill.create(bill_params)
        if @bill.save
            redirect_to @bill #show
        else
            redirect_to new_bill_path #new
        end
    end

    def edit
        
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

    def set_bill
        @bill = Bill.find(params[:id])
    end

    def bill_params
        params.require(:bill).permit(
            :month_id,
            :year,
            :price, 
            :detail, 
            :category_id
        )
        
    end
end
