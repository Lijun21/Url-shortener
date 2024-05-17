# URL Shortener

This web application built with Elixir and Phoenix, provides URL shortening, statistics display, and CSV export functionality.

## Application Features

1. **URL Shortening:**
    - Submit a long URL via the form to receive a shortened version.
   <img width="952" alt="Screenshot 2024-05-12 at 11 35 27 AM" src="https://github.com/Lijun21/Url-shortener/assets/20981745/1d02063f-6332-4f55-899b-6950b37fe80e">
   <img width="957" alt="Screenshot 2024-05-12 at 11 35 41 AM" src="https://github.com/Lijun21/Url-shortener/assets/20981745/428e6a69-388f-49eb-b675-d5ac1976acb3">


2. **Statistics:**
    - View all submitted URLs, their original versions, and their click counts on the /stats page.
    <img width="1061" alt="Screenshot 2024-05-12 at 11 38 01 AM" src="https://github.com/Lijun21/Url-shortener/assets/20981745/41e2569d-7ebf-4968-8664-42cde462c6b5">

    - Download this data as a CSV.
    <img width="843" alt="Screenshot 2024-05-12 at 11 43 35 AM" src="https://github.com/Lijun21/Url-shortener/assets/20981745/8f1c7f74-385d-45ae-996d-5e0747d66f8d">

    

## Prerequisites

1. **Elixir & Erlang:**
   Elixir is built on the Erlang VM (BEAM), and using it for web applications often involves the Phoenix framework.
   - Install Elixir and Erlang: Follow the installation guides available on the [Elixir's website](https://elixir-lang.org/install.html).
   - Install Phoenix by following the instructions on the [Phoenix Installation Guide](https://hexdocs.pm/phoenix/installation.html)

3. **Database:**
   - Install PostgreSQL, and start PostgreSQL service. (Keep it running)
  
     ```
     # downlaod PostgreSQL
     brew install postgresql

     # start postgresql service: 
     brew services start postgresql@15
     ```
     
   - Create a database user with the necessary privileges.
     
     ```
     # Open a terminal window and switch to the postgres user account (created by default)
     psql postgres

     # Create a new user
     CREATE ROLE Your_Username WITH LOGIN PASSWORD 'Your_Password';

     # Exit the PostgreSQL prompt
     \q
     ```
   - Create a new database that your application will use.
     ```
     createdb -O Your_Username Your_Database_Name
     ```

## Setup Instructions

1. **Clone the Repository:**
      ```bash
      git clone https://github.com/yourusername/your-repo.git
      cd Url-shortener
      ```

2. **Configure the Database:**
      ```
      export PSQL_DB_NAME=Your_Database_Name
      export PSQL_DB_USER_NAME=Your_Username
      export PSQL_DB_USER_PW=Your_Password
      ```
  
4. **create and migrate DB:**
      We use mix as an interface to interact with the app.
      ```
      # Set up your database 
      mix ecto.create
   
      # apply migrations 
      mix ecto.migrate
      ```
   
6. **Install Dependencies:**
      Retrieve and install the necessary dependencies. 
      
      ```bash
      mix deps.get
      ```
7. **Compile the application code:**
      ```
      mix compile
      ```

8. **Start the Server:**
     Launch the Phoenix server using:
     ```
     mix phx.server
     ```
   
     or start with inline environment variables if you want to skipped setup #2
      
     ```
     PSQL_DB_NAME=Your_Database_Name PSQL_DB_USER_NAME=Your_User_Name  PSQL_DB_USER_PW=Your_Database_PW  mix phx.server
     ```

   Visit http://localhost:4000 to access the application.


## Testing

1. **Run Tests:**
   To run all the test scripts defined in the test directory:
   ```
   mix test
   ```


## CI/CD
Each push to the main branch triggers a GitHub Action, as defined in the .github/workflows/elixir_CI.yml file. This action sets up a Docker container on an Ubuntu server with Elixir and PostgreSQL installed. It executes all tests to verify that your changes do not break existing features.


## Notes to Engineering Team

1. **Scalability:**
   - The tech stack, utilizing the Phoenix framework along with Elixir's concurrency model and PostgreSQL, the application is designed to handle intensive workloads efficiently.

2. **Assumptions:**
   - Request Handling: The application is expected to manage up to 5 requests per second via the creation API. Over a span of 10 years, this equates to approximately 1.6 billion unique records.
   - Slug Design: For ease of use and memory, slugs are 6 characters in length, composed of lowercase letters and numbers. This design avoids complications with letter casing and supports around 2 billion unique entries without conflicts.

3. **Potential Improvements:**
   - Consider adding authentication to enhance security and allow URL editing, so that user can specify their own URL. or delte exist URL.
   - Implementing a caching layer could significantly improve performance, especially for frequently accessed URLs, reducing load on the database and speeding up response times.
