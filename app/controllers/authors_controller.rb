class AuthorsController < ApplicationController
    get "/authors" do
        if is_logged_in?(session) 
            @authors = Author.all
            erb :"/authors/index"
        else
            redirect "/login"
        end
    end

    get "/authors/:id" do
        
    end

    get "/authors/:id/edit" do
        
    end

    patch "/authors/:id" do
        
    end

    delete "/authors/:id" do
        
    end
end