# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    - App uses Sinatra DSL
- [x] Use ActiveRecord for storing information in a database
    - App uses ActiveRecord
- [x] Include more than one model class (e.g. User, Post, Category)
    - App includes Author and Book classes
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    - Author has_many Books
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    - Book belongs_to Author
- [x] Include user accounts with unique login attribute (username or email)
    - Author accounts have unique logins
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    - Books have Create, Read, Update, and Destroy routes
- [x] Ensure that users can't modify content created by other users
    - App checks if author owns a book before allowing them to edit (route); the view also hides the edit button.
- [x] Include user input validations
    - App includes validates for unique users, and the presence of required data. Advances must be a number.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    - Errors are displayed via `flash[:message]`.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message