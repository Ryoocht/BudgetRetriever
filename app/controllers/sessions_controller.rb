class SessionsController < ApplicationController
    skip_before_action :require_logged_in, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        user = User.find_by(name: params[:user][:name])
        user = user.try(:authenticate, params[:user][:password])
        return redirect_to(controller: 'sessions', action: 'new') unless user
        session[:user_id] = user.id
        @user = user
        redirect_to new_account_path
    end

    def facebookAuth
        puts "FacebookAuth METHOD IS CALLED"
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
        end
    
        session[:user_id] = @user.id
        redirect_to new_account_path
    end

    def googleAuth
        puts "GoogleAuth METHOD IS CALLED"
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
            access_token = auth
            u.google_token = auth.credentials.token
            refresh_token = auth.credentials.refresh_token
            u.google_refresh_token = refresh_token if refresh_token.present?
            u.password = SecureRandom.urlsafe_base64
        end

        if @user.valid?
            session[:user_id] = @user.id
            redirect_to new_account_path
        else
            flash[:message] = "Credential Error"
            redirect login_path
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