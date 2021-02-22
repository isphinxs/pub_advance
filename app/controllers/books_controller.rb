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

    get "/books/:slug" do 
        if is_logged_in?(session)
            @book = Book.find_by_slug(params[:slug])
            @author = @book.author
            @owns_book = @author == current_author ? true : false
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
                redirect "/books/new", flash[:message] = "All fields must be filled out."
            else
                book = Book.new(title: title, year_published: year_published, advance: advance, author_id: current_author.id)
                if book.save
                    slug = book.slug
                    redirect "/books/#{slug}", flash[:message] = "You have successfully added a new book."
                else
                    redirect "/books/new", flash[:message] = "There was an error creating a new book. Please try again."
                end
            end
        else 
            redirect "/login"
        end
    end

    get "/books/:slug/edit" do
        if is_logged_in?(session)
            @book = Book.find_by_slug(params[:slug])
            if @book.author_id == current_author.id
                @author = current_author
                erb :"books/edit"
            else
                redirect "/books", flash[:message] = "There was an error with that book. Please try a different book."
            end
        else
            redirect "/login"
        end
    end

    patch "/books/:slug" do
        if is_logged_in?(session)
            slug = params[:slug]
            book = Book.find_by_slug(slug)
            title = params[:title]
            year_published = params[:year_published]
            advance = params[:advance]
            if title.blank? || year_published.blank? || advance.blank?
                redirect "/books/#{slug}/edit", flash[:message] = "All fields must be filled out."
            else
                book.title = title
                book.year_published = year_published
                book.advance = advance
                if book.save
                    redirect "/books/#{slug}", flash[:message] = "You have successfully updated your book."
                else
                    redirect "/books/#{slug}/edit", flash[:message] = "There was an error updating your book. Please try again."
                end
            end
        else
            redirect "/login"
        end
    end

    delete "/books/:id" do
        if is_logged_in?(session)
            slug = params[:slug]
            book = Book.find_by_slug(slug)
            if book.author_id == current_author.id
                book.destroy
                redirect "/books", flash[:message] = "You have succesfully deleted the book."
            else
                redirect "/books/#{slug}", flash[:message] = "There was an error deleting your book. Please try again."
            end
        else
            redirect "/login"
        end
    end
end