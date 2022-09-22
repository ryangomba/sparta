class SnippetsController < ApplicationController

    def index
        params[:page] ? offset = params[:page] : offset = 0
        @snippets = Snippet.limit(50).offset(offset)
        unless @snippets.empty? then session[:last_polled] = @snippets.first.id end
    end
    
    def poll
        @snippets = Snippet.where("id > :last_polled", { :last_polled => session[:last_polled] })
        unless @snippets.empty? then session[:last_polled] = @snippets.first.id end
        respond_to do |format|
            format.js
        end
    end
    
    def create
        @user = User.find_or_create_by_device_id(params[:user_email]) if params[:user_email]
        @user = User.find_or_create_by_device_id(params[:device_id]) if @user.nil?
        @snippet = @user.snippets.create(params[:snippet])
        render :nothing => true
    end

end
