class BooksController < ApplicationController
    get "/books" do
        if is_logged_in?(session) 
            @books = Book.all
            erb :"/books/index"
        else
            redirect "/login"
        end
    end

    get "/books/new" do
        
    end

    get "/books/:id" do # update to title slug?
        if is_logged_in?(session)
            @book = Book.find(params[:id])
            @author = @book.author
            erb :"books/show"
        else
            redirect "/login"
        end
    end

    post "/books" do
        
    end

    get "/books/:id/edit" do
        
    end

    patch "/books/:id" do
        
    end

    delete "/books/:id" do
        
    end
end