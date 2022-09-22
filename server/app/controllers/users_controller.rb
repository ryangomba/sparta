class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        params[:page] ? offset = (Integer(params[:page]) - 1) * 50 : offset = 0
        @snippets = @user.snippets.limit(50).offset(offset)
    end
    
    def poll
        @user = User.find(params[:id])
        @snippets = @user.snippets.where("id > :last_polled", { :last_polled => session[:last_polled] })
        unless @snippets.empty? then session[:last_polled] = @snippets.first.id end
        respond_to do |format|
            format.js
        end
    end

end
