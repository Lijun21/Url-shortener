defmodule UrlShortenerWeb.StatsController do
  use UrlShortenerWeb, :controller
  alias UrlShortener.Urls

  def show_stats(conn, _params) do
    # Retrieve all URL records
    urls = Urls.list_urls()

    # Check for the "download" parameter to generate a CSV
    if conn.params["download"] do
      csv_content = generate_csv(urls)
      send_download(conn, {:binary, csv_content}, filename: "url_stats.csv")
    else
      render(conn, :index, urls: urls, layout: false)
    end
  end

  # Generate a CSV string from the list of URL records
  defp generate_csv(urls) do
    headers = ["Slug", "Original URL", "Click Count"]
    rows = Enum.map(urls, fn url ->
      [url.slug, url.original_url, url.click_count]
    end)

    CSV.encode([headers | rows]) |> Enum.join("\n")
  end
end
