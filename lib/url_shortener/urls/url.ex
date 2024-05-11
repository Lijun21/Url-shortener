# lib/url_shortener/urls/url.ex
defmodule UrlShortener.Urls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :slug, :string
    field :original_url, :string
    field :click_count, :integer, default: 0

    timestamps()
  end

  def changeset(url, attrs) do
    IO.inspect(url, label: "--------url")
    IO.inspect(attrs, label: "--------attrs")
    url
    |> cast(attrs, [:slug, :original_url, :click_count])
    |> validate_required([:slug, :original_url])
    |> validate_url_format(:original_url) # Custom URL format validation
    |> unique_constraint(:slug)
  end

  # Custom validation function to ensure the URL is valid
  defp validate_url_format(changeset, field) do
    validate_change(changeset, field, fn _, value ->
      case URI.parse(value) do
        %URI{scheme: scheme, host: host} when scheme in ["http", "https"] and host not in [nil, ""] ->
          [] # No errors
        _ ->
          [{field, "is not a valid URL"}] # Returns an error tuple for the field
      end
    end)
  end

end
