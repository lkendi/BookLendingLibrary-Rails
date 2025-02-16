# Book Lending Library

A simple book lending library application built with Ruby on Rails 8. This application allows registered users to browse available books, borrow a book, return a book, and view the list of books they have currently borrowed. When a user borrows a book, a Borrowing record is created that associates the Book and the User with a due date set for 2 weeks from the borrowing date. There also is the admin panel, allowing admin users to add, edit and delete books.


## Features

- **User Login**
  Uses Rails 8's default authentication system.

- **Book Catalog**
  - List of books with title, author, and ISBN.
  - Availability status displayed for each book.
  - Book details page with a "Borrow" button if the book is available.

- **Borrowing System**
  - Create a Borrowing record when a user borrows a book.
  - Each borrowing includes a due date (2 weeks from the borrowing date).
  - Prevents borrowing a book that is already borrowed (active borrowing exists).

- **User Profile**
  - View a list of currently borrowed books.
  - Return books using the "Return" action (active for borrowings not yet returned).

- **Validations & Error Handling**
  - Books require title, author, and ISBN (unique and must be 10 or 13 digits).
  - Users must register with a valid, unique email address.

- **Testing**
  - Tests for models, controllers, and views using Rails' default testing framework.

## Setup Instructions

### Prerequisites

- Ruby 3.x (recommended)
- Rails 8.x
- SQLite3 (or your preferred database as configured in `config/database.yml`)

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/lkendi/BookLendingLibrary-Rails.git
   cd BookLeendingLibrary-Rails
   ```
2. **Install dependencies**
    ```bash
    bundle install
    ```
3. **Set up the database**
    ```bash
    rails db:migrate db:fixtures:load
    ```

    This loads some records of books and borrowings which can be accessed in the `test/fixtures` directory. Login credentials when accessing the application:
    * Admin user - Email: one@example.com, Password: password
    * Regular user - Email: two@example.com, Password: password
    * Alternative regular user - Email: three@example.com, Password: password


4. **Access the application**
- Start the Rails server:
```bash
rails server
```

Then, open your web browser and navigate to http://localhost:3000 to access the application.

### Running Tests

Run the test suite using Rails' default testing framework:
```bash
rails test
```

## Project Structure

-   **app/models/**
    Contains the `Book`, `Borrowing`, and `User` models along with their validations and associations.

-   **app/controllers/**
    Handles requests for books, borrowings, sessions, and user profiles.

-   **app/views/**
    Contains structured views for book listings, book details, user profiles, and borrowing actions.

-   **test/**
    Contains tests for models, controllers, and views.

