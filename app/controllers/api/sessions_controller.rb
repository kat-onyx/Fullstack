class Api::SessionsController < ApplicationController
    def create 
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
            )

        if @user
            login!(@user)
            render json: "#{current_user}, #{current_user.session_token}"
        else
            render ["Invalid login credentials"], status: 401
        end
    end

    def destroy
        if current_user 
            logout 
            render "api/users/show"
        else
            render json: ["No one currently signed in"], status: 404
        end
    end
end
