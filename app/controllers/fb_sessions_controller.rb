class FbSessionsController < ApplicationController
    skip_before_action :require_logged_in, only: [:create]
    
    def create
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
        end
    
        session[:user_id] = @user.id
    
        redirect_to new_account_path
      end
    
      private
    
      def auth
        request.env['omniauth.auth']
    end
end