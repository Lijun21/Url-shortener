# lib/url_shortener_web/controllers/url_controller.ex
require Logger

defmodule UrlShortenerWeb.UrlController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.Urls

  # Displays the form to create a new short URL
  def index(conn, _params) do
    Logger.debug("Loading form to create a new URL.")
    render(conn, :index, layout: false)
  end

  # Create short URL
  def create(conn, %{"original_url" => original_url}) do
    # Create a new shortened URL
    case Urls.create_url(%{"original_url" => original_url}) do
      {:ok, url} ->
        Logger.info("Shorten URL created successfully: #{url.slug}")
        conn
        |> render("show.html", original_url: original_url, shortened_url: "http://localhost:4000/#{url.slug}", layout: false)

      {:error, changeset} ->

        Logger.error("Failed to create URL: #{inspect(changeset)}")
        conn
        |> render("index.html", changeset: changeset, layout: false)
    end
  end

  # Redirects a slug to its original URL
  def show(conn, %{"slug" => slug}) do
    case Urls.get_url_by_slug(slug) do
      nil ->
        Logger.warning("URL not found for slug: #{slug}")
        send_resp(conn, 404, "URL not found")
      url ->
        Urls.increment_click_count(url)
        Logger.info("Redirecting slug: #{slug} to original URL: #{url.original_url}")
        redirect(conn, external: url.original_url)
    end
  end
end
