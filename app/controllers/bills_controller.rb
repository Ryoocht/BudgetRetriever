class BillsController < ApplicationController
    before_action :set_category, only: [:new, :edit]
    before_action :set_bill, only: [:show, :edit, :update, :destroy]
    before_action :set_account, only: [:index, :show, :new, :create]

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
        @bill = Bill.create(bill_params)
        if @bill.save
            redirect_to account_bill_path(@account, @bill)
        else
            redirect_to new_account_bill_path
        end
    end

    def edit
        @bill = Bill.find(params[:id])
        @months = Month.all
        @account = Account.find(params[:account_id])
    end
    
    def update
        @bill_param.update(bill_params)
        account = bill_params[:account_id]
        redirect_to account_bills_path(account)
    end

    def destroy
        if @bill_param.destroy
            redirect_to account_bills_path
        end
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
        @bill_param = Bill.find(params[:id])
    end

    def set_account
        @account = Account.find(params[:account_id])
    end

    def bill_params
        params.require(:bill).permit(
            :user_id,
            :month_id,
            :year,
            :price, 
            :detail, 
            :category_id,
            :subcategoryid,
            :further_subcategoryid,
            :account_id
        )
    end
end
