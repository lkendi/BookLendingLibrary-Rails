# **BookLendingLibrary - Rails Library Management System**

![Rails Version](https://img.shields.io/badge/Rails-8.0.0-red)  
![Ruby Version](https://img.shields.io/badge/Ruby-3.2.0-green)

BookLender is a simple book lending library application built with Ruby on Rails 8. It allows registered users to browse books, borrow and return them, and view their borrowing history. An admin panel  enables book management (CRUD) and access to borrowing records.


## Features
### **General Features**

✅ **Role-Based Access Control** (Admin & User)  
✅ **Secure Authentication & Registration** (Rails 8 default authentication)  
✅ **Search & Browse Books**

### User Features

- Borrow books
- View personal borrowing history with due dates
- Return Books (Making them available for others)

### Admin Features

- Manage Books (Create, Update, Delete)
- View Borrowing History (Per Book)


## Tech Stack

-   **Framework**: Ruby on Rails 8
-   **Database**: SQLite (or preferred database)
-   **Frontend**: Tailwind CSS


## Setup Instructions

### Prerequisites

- Ruby 3.x (recommended)
- Rails 8.x
- SQLite3 (or preferred database)
- Tailwind 4.x

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

    This loads sample users, book and borrowing records from the `test/fixtures` directory.


4. **Access the application**
- Start the Rails server:
```bash
rails server
```

Then, visit **[http://localhost:3000](http://localhost:3000)** in your browser.

### User Flow

1.  Register at `/users/new` then Login at `sessions/new`
2.  Browse books at `/books`
3.  Borrow available books
4.  Manage Borrowings (My Borrowings section)
    -   View current borrows
    -   Return books
    -   Check borrowing history

### Admin Flow

1.  Login as admin
2.  Manage Books (`/books`)
  -   Add new books (`/books/new`)
  -   Edit books (`/books/:id/edit`)
  -   View book-specific borrow history (`/books/:id`)

### Running Tests

Run the test suite using Rails' default testing framework:
```bash
rails test
```

## Project Structure

📁 **app/models/** → Contains `Book`, `Borrowing`, and `User` models with validations & associations.  
📁 **app/controllers/** → Manages requests for books, borrowings, sessions, and user profiles.  
📁 **app/views/** → Handles book listings, details, user profiles, and borrowing actions.  
📁 **test/** → Contains model, controller, and integration tests.
