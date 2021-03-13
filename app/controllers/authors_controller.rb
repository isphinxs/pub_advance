class AuthorsController < ApplicationController
    get "/authors" do
        redirect_if_not_logged_in
        @authors = Author.all
        erb :"/authors/index"
    end

    get "/authors/:slug" do
        redirect_if_not_logged_in
        @author = Author.find_by_slug(params[:slug])
        if @author
            @owns_author = @author == current_author ? true : false
            @books = @author.books.all
            erb :"authors/show"
        else
            flash[:message] = "That author is not available."
            redirect "/authors"
        end
    end

    get "/authors/:slug/edit" do
        redirect_if_not_logged_in
        @author = Author.find_by_slug(params[:slug])
        if @author == current_author
            erb :"authors/edit"
        else
            redirect "/authors", flash[:message] = "There was an error. Please try again." # flash, or update to a page that says you're not permitted to edit/author doesn't exist?
        end
    end

    patch "/authors/:slug" do
        redirect_if_not_logged_in
        slug = params[:slug]
        author = Author.find_by_slug(slug)
        name = params[:name]
        username = params[:username]

        if author != current_author
            redirect "/authors", flash[:message] = "There was an error. Please try again."
        end

        if name.blank? || username.blank?
            redirect "/authors/#{slug}/edit", flash[:message] = "All fields must be filled out."
        else
            if author.update(name: name, username: username)
                slug = author.slug
                redirect "/authors/#{slug}", flash[:message] = "You have successfully updated your account."
            else
                redirect "/authors/#{slug}/edit", flash[:message] = "There was an error updating your account. Please try again."
            end
        end
    end

    delete "/authors/:slug" do
        redirect_if_not_logged_in
        slug = params[:slug]
        author = Author.find_by_slug(slug)
        if author == current_author
            # what to do with author's books?
            Author.delete(author.id)
            session.clear
            redirect "/", flash[:message] = "You have successfully deleted your account"
        else
            redirect "/books/#{slug}", flash[:message] = "There was an error deleting the account. Please try again."
        end
    end
end