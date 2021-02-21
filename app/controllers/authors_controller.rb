class AuthorsController < ApplicationController
    get "/authors" do
        if is_logged_in?(session) 
            @authors = Author.all
            erb :"/authors/index"
        else
            redirect "/login"
        end
    end

    get "/authors/:slug" do
        if is_logged_in?(session)
            # @author = Author.find(params[:id])
            @author = Author.find_by_slug(params[:slug])
            @logged_in = @author == current_author ? true : false
            @books = @author.books.all
            erb :"authors/show"
        else
            redirect "/login"
        end
    end

    get "/authors/:id/edit" do
        
    end

    patch "/authors/:id" do
        
    end

    delete "/authors/:id" do
        
    end
end