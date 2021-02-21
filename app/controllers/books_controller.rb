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
        if is_logged_in?(session)
            @author = current_author
            erb :"books/new"
        else
            redirect "/login"
        end
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
        if is_logged_in?(session)
            title = params[:title]
            year_published = params[:year_published]
            advance = params[:advance]
            if title.blank? || year_published.blank? || advance.blank?
                redirect "/books/new" # flash, or update to a page with the data already filled out?
            else
                book = Book.new(name: title, year_published: year_published, advance: advance, author_id: current_author.id)
                if book.save
                    id = book.id
                    redirect "/books/#{id}"
                else
                    redirect "/books/new" # flash, or update to a page with the data already filled out?
                end
            end
        else 
            redirect "/login"
        end
    end

    get "/books/:id/edit" do
        
    end

    patch "/books/:id" do
        
    end

    delete "/books/:id" do
        
    end
end