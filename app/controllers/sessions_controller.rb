class SessionsController < ApplicationController
    skip_before_action :require_logged_in, only: [:new, :create]

    def new
        
    end

    def create
        if params[:user][:name]
            user = User.find_by(name: params[:user][:name])
            user = user.try(:authenticate, params[:user][:password])
            return redirect_to(controller: 'sessions', action: 'new') unless user
            session[:user_id] = user.id
            @user = user
            redirect_to new_account_path
        elsif auth['uid']
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.name = auth['info']['name']
                u.email = auth['info']['email']
                u.image = auth['info']['image']
            end
            session[:user_id] = @user.id
            render 'welcome/home'
        end
    end

    def destroy
        session.delete :user_id
        redirect_to '/login'
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end