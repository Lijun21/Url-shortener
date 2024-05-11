# URL Shortener Application

A web application built with Elixir and Phoenix that provides URL shortening, statistics display, and CSV export functionality.

## Prerequisites

1. **Elixir & Erlang:**
   - Install Elixir and Erlang by following the instructions on [Elixir's website](https://elixir-lang.org/install.html).

2. **Database:**
   - Ensure you have PostgreSQL installed and running.
   - Create a database user and a new database.

## Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo

2. **Configure the Database:**
   ```bash
   Update config/dev.exs (and other config files) with your PostgreSQL credentials.

3. **Install Dependencies:**
   ```bash
   mix deps.get

4. **Setup the Database:**
   ```bash
    Start the Phoenix server using:
  ```
  mix phx.server
  ```
  Visit http://localhost:4000 to access the application.


## Testing

1. **Run Tests:**
   To run tests:
   ```bash
   mix test
   ```

2. **Load Testing:**
   ```bash
   Optionally, you can use a load testing tool like k6 or Apache JMeter to test the application's performance.




## Application Features

1. **URL Shortening:**
   ```bash
    Submit a long URL via the form to receive a shortened version.  

2. **Statistics:**
   ```bash
    View all submitted URLs, their original versions, and their click counts on the /stats page.
    Download this data as a CSV.


## Notes to Engineering Team

1. **Scalability:**
    he Phoenix framework and Elixir's concurrency model ensure scalability with high throughput and low latency.

2. **Assumptions:**
    The application assumes proper PostgreSQL configuration and a correctly set up environment.

3. **Potential Improvements:**
    Consider adding authentication to enhance security and allow URL editing/deletion.
    A caching layer could further optimize performance for frequent requests.