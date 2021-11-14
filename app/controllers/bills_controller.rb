class BillsController < ApplicationController
    before_action :set_category, only: [:new, :edit, :total]
    before_action :set_bill, only: [:show, :edit, :update, :destroy]
    before_action :set_account, only: [:index, :show, :new, :create, :total]
    before_action :set_months, only: [:new, :edit, :total]

    def index
        @bills = Bill.where(account_id: @account)
    end

    def show
    end

    def new
        @bill = Bill.new
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

    def total
        @category_total = {}
        @subcategory_total = {}
        @further_subcategory_total = {}
        total_array = []
        sub_cate_array = []
        fur_sub_cate_array = []
        main_count = 0
        sub_count = 0
        fur_sub_count = 0
        @category_parent_array.each do |main|
            @months.each do |month|
                # Main category total
                total_array << Bill.main_category_scope(main.id, month.id)
                @category_total[:"#{main.name}"] = total_array.slice(12*main_count, 12 * (main_count+1))
                
            end

            # Subcategory total
            Category.find_by(id: main.id).children.each do |child|
                @months.each do |month|
                    sub_cate_array << Bill.subcategory_scope(child.id, month.id)
                    @subcategory_total[:"#{child.name}"] = sub_cate_array.slice(12*sub_count, 12 * (sub_count+1))
                end
                
                # Further Subcategory total
                Category.find_by(id: child.id).children.each do |grand_child|
                    @months.each do |month|
                        fur_sub_cate_array << Bill.further_subcategory_scope(grand_child.id, month.id)
                        @further_subcategory_total[:"#{grand_child.name}"] = fur_sub_cate_array.slice(12*fur_sub_count, 12 * (fur_sub_count+1))
                    end
                    fur_sub_count += 1
                end
                sub_count +=1
            end
            main_count += 1
        end
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

    def set_months
        @months = Month.all
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
