require "./config/environment"
require "sinatra/base"

class ApplicationController < Sinatra::Base
    configure do
        enable :sessions
        set :views, "app/views"
    end

    get "/" do
        "Test"
    end
end