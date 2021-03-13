class BooksController < ApplicationController
    get "/books" do
        redirect_if_not_logged_in
        @books = Book.all
        erb :"/books/index"
    end
    
    get "/books/new" do
        redirect_if_not_logged_in
        @author = current_author
        erb :"books/new"
    end
    
    get "/books/alpha" do
        redirect_if_not_logged_in
        @books = Book.order(:title)
        erb :"/books/index"
    end
    
    get "/books/pubyear" do
        redirect_if_not_logged_in
        @books = Book.order(:year_published)
        erb :"/books/index"
    end
    
    get "/books/:slug" do 
        redirect_if_not_logged_in
        @book = Book.find_by_slug(params[:slug])
        if @book
            @author = @book.author
            @owns_book = @author == current_author ? true : false
            erb :"books/show"
        else
            flash[:message] = "That book is not available."
            redirect "/books"
        end
    end

    post "/books" do
        redirect_if_not_logged_in
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
    end

    get "/books/:slug/edit" do
        redirect_if_not_logged_in
        @book = Book.find_by_slug(params[:slug])
        if @book.author_id == current_author.id
            @author = current_author
            erb :"books/edit"
        else
            redirect "/books", flash[:message] = "There was an error with that book. Please try a different book."
        end
    end

    patch "/books/:slug" do
        redirect_if_not_logged_in
        slug = params[:slug]
        book = Book.find_by_slug(slug)
        title = params[:title]
        year_published = params[:year_published]
        advance = params[:advance]

        if book.author_id != current_author.id
            redirect "/books", flash[:message] = "There was an error. Please try again."
        end

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
    end

    delete "/books/:slug" do
        redirect_if_not_logged_in
        slug = params[:slug]
        book = Book.find_by_slug(slug)
        if book.author_id == current_author.id
            book.destroy
            redirect "/books", flash[:message] = "You have succesfully deleted the book."
        else
            redirect "/books/#{slug}", flash[:message] = "There was an error deleting your book. Please try again."
        end
    end

    private

    
end