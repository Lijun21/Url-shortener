defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

  # Browser pipeline to handle HTML requests
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # API pipeline to handle JSON requests
  pipeline :api do
    plug :accepts, ["json"]
  end

  # API scope remains as-is
  scope "/api", UrlShortenerWeb do
    pipe_through :api
    post "/create", UrlController, :create

  end

  # Add the new scope for URL shortener browser routes
  scope "/", UrlShortenerWeb do
    pipe_through :browser

    # Route definitions for URL shortening
    get "/", UrlController, :index
    post "/create", UrlController, :create

    # Add a route for viewing the statistics
    get "/stats", StatsController, :show_stats
    get "/:slug", UrlController, :show

  end

  # Development features (LiveDashboard, Swoosh Mailbox Preview)
  if Application.compile_env(:url_shortener, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: UrlShortenerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
