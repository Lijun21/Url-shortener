# Business logics for URL shortener application
# lib/url_shortener/urls.ex
defmodule UrlShortener.Urls do
  alias UrlShortener.Repo
  alias UrlShortener.Urls.Url

  # List all URL records
  def list_urls do
    Repo.all(Url)
  end

  # Retrieve a URL by slug
  def get_url_by_slug(slug), do: Repo.get_by(Url, slug: slug)

  # Increment the click count for a URL
  def increment_click_count(%Url{} = url) do
    url
    |> Ecto.Changeset.change(click_count: url.click_count + 1)
    |> Repo.update()
  end

  # Create a new shortened URL record
  def create_url(attrs \\ %{}) do
    slug = generate_slug()
    attrs = Map.put(attrs, "slug", slug)

    %Url{}
    |> Url.changeset(attrs)
    |> Repo.insert()
  end

  # Generate a 6-character slug using Base36 with only lowercase characters
  defp generate_slug do
    # Calculate the maximum Base36 value possible for 6 characters
    max_value = 36 |> :math.pow(6) |> round()
    random_int = :rand.uniform(max_value) - 1

    # Convert to Base36 string and ensure it's lowercase
    Integer.to_string(random_int, 36)
    |> String.pad_leading(6, "0")
    |> String.downcase()
  end

end
