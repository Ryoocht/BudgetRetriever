class AccountsController < ApplicationController
    def new
        @users_accounts = UsersAccount.all
        @accounts = Account.all
        @account = Account.new
    end

    def create
        if account_params[:account_id]
            find_account = Account.find_by(id: account_params[:account_id])
            if find_account
                @account = find_account
                redirect_to account_bills_path(@account)
            else
                render :new
            end
        else
            account = Account.new(account_params)
            if account.save
                @account = account
                redirect_to account_bills_path(@account)
            else
                render :new
            end
        end
        
    end

    def show

    end

    private

    def account_params
        params.require(:account).permit(:name, :account_id, user_id:[])
    end
end