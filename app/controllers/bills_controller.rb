class BillsController < ApplicationController
    before_action :set_category, only: [:new]
    before_action :set_bill, only: [:show, :edit, :update, :destroy]

    def show
        @category_parent_array = ["---"]
        Category.where(ancestry: nil).each do |parent|
            @category_parent_array << parent.name
        end
    end

    def new
        @bill = Bill.new
        @months = Month.all
    end

    def create
        @bill = Bill.new(bill_params)
        respond_to do |format|
            if @bill.save
                format.html{ redirect_to @bill, notice: "Bill record was successfully created." }
                format.json { render action: "show", status: :create, location: @bill }
            else
                format.html { render action: "new" }
                format.json { render json: @bill.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        
    end

    def get_category_children
        @category_children = Category.find(params[:category_id]).children
    end

    def get_category_grandchildren
        @category_grandchildren = Category.find(params[:category_id]).children
        puts Category.find(params[:category_id]).children
    end

    private

    def set_category
        @category_parent_array = Category.where(ancestry: nil)
    end

    def set_bill
        @bill = Bill.find(params[:id])
    end

    def bill_params
        params.require(:bill).permit(:name, :year, :price, :detail, :category => [])
    end
end
