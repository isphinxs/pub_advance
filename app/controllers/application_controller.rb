require "./config/environment"
require "sinatra/base"
require "sinatra/flash"

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
        register Sinatra::Flash
    end

    get "/" do
        erb :index
    end

    get "/signup" do
        if is_logged_in?(session)
            redirect "/books", flash[:message] = "You are already logged in."
        else
            erb :signup
        end
    end

    post "/signup" do
        name = params[:name]
        username = params[:username]
        password = params[:password]
        if is_logged_in?(session)
            redirect "/books", flash[:message] = "You are already logged in."
        elsif name.blank? || username.blank? || password.blank?
            redirect "/signup", flash[:message] = "Please fill out all requested fields to sign up."
        else
            author = Author.new(params)
            if author.save
                session[:author_id] = author.id
                redirect "/books", flash[:message] = "You have successfully created an account. Welcome, #{name}."
            else
                redirect "/signup", flash[:message] = "This username is taken. Please select another username."
            end
        end
    end

    get "/login" do
        if is_logged_in?(session)
            redirect "/books", flash[:message] = "You are already logged in."
        else
            erb :login
        end
    end

    post "/login" do
        author = Author.find_by(username: params[:username])
        if is_logged_in?(session)
            redirect "/books", flash[:message] = "You are already logged in."
        elsif author && author.authenticate(params[:password])
            session[:author_id] = author.id
            redirect "/books", flash[:message] = "Welcome, #{author.name}!"
        else
            redirect "/login", flash[:message] = "Your credentials are not correct. Please try again."
        end
    end

    get "/logout" do
        if is_logged_in?(session)
            session.clear
            redirect "/", flash[:message] = "You have successfully logged out."
        else 
            redirect "/signup"
        end
    end

    helpers Helpers
end