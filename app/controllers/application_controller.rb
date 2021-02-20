require "./config/environment"
require "sinatra/base"

module Helpers
    def is_logged_in?(session)
        !!session[:author_id]
    end

    def current_author
        Author.find(session[:author_id])
    end
end

class ApplicationController < Sinatra::Base
    configure do
        enable :sessions
        set :views, "app/views"
    end

    get "/" do
        erb :index
    end

    get "/signup" do
        erb :signup
    end

    post "/signup" do
        name = params[:name]
        username = params[:username]
        password = params[:password]
        if is_logged_in?(session)
            redirect "/"
        elsif name.blank? || username.blank? || password.blank?
            redirect "/signup"
        else
            author = Author.new(params)
            redirect "/success"
        end
    end
    
    get "/success" do
        "Successfully signed up"
    end

    get "/login" do
        
    end

    get "/logout" do
        
    end

    helpers Helpers
end