class AccountsController < ApplicationController
    def new
        @account = Account.new
    end

    def create
        account = Account.create(account_params)
        if account.save
            @account = account
            redirect_to new_bill_path
        else
            render :new
        end
    end

    private

    def account_params
        params.require(:account).permit(:name, :user_id)
    end
end