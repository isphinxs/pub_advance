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
    
    end
    
    get "/login" do
        
    end

    get "/logout" do
        
    end

    helpers Helpers
end