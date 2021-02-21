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
        if is_logged_in?(session)
            @book = Book.find(params[:id])
            if @book.author_id = current_author.id
                @author = current_author
                erb :"books/edit"
            else
                redirect "/books" # flash, or update to a page that says you're not permitted to edit/book doesn't exist?
            end
        else
            redirect "/login"
        end
    end

    patch "/books/:id" do
        if is_logged_in?(session)
            id = params[:id]
            book = Book.find(id)
            title = params[:title]
            year_published = params[:year_published]
            advance = params[:advance]
            if title.blank? || year_published.blank? || advance.blank?
                redirect "/books/#{id}/edit" # flash, or update to a page that says you've made a mistake?
            else
                book.name = title
                book.year_published = year_published
                book.advance = advance
                if book.save
                    redirect "/books/#{id}"
                else
                    redirect "/books/#{id}/edit" # flash, or update to a page that says there's been a mistake?
                end
            end
        else
            redirect "/login"
        end
    end

    delete "/books/:id" do
        
    end
end