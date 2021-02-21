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
        set :session_secret, ENV["SESSION_SECRET"]
        set :views, "app/views"
    end

    get "/" do
        erb :index
    end

    get "/signup" do
        if is_logged_in?(session)
            redirect "/already-logged-in"
        else
            erb :signup
        end
    end

    post "/signup" do
        name = params[:name]
        username = params[:username]
        password = params[:password]
        if is_logged_in?(session)
            redirect "/already-logged-in"
        elsif name.blank? || username.blank? || password.blank?
            redirect "/signup"
        else
            author = Author.new(params)
            if author.save
                session[:author_id] = author.id
                redirect "/success-signup"
            else
                # handle failure
            end
        end
    end

    get "/login" do
        if is_logged_in?(session)
            redirect "/already-logged-in"
        else
            erb :login
        end
    end

    post "/login" do
        author = Author.find_by(username: params[:username])
        if is_logged_in?(session)
            redirect "/already-logged-in"
        elsif author && author.authenticate(params[:password])
            session[:author_id] = author.id
            redirect "/success-login"
        end
    end

    get "/logout" do
        if is_logged_in?(session)
            session.clear
            redirect "/login"
        else 
            redirect "/"
        end
    end

    # Routes for testing
    get "/success-signup" do
        "Successfully signed up"
    end

    get "/success-login" do
        "Successfully logged in"
    end

    get "/already-logged-in" do
        "You are already logged in"
    end

    helpers Helpers
end