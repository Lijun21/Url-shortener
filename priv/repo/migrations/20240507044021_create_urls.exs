defmodule UrlShortener.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original_url, :string
      add :slug, :string
      add :click_count, :integer, default: 0

      timestamps()
    end

    # Unique index on `slug` field
    create unique_index(:urls, [:slug])

    # Index on `original_url` to optimize direct URL queries (if needed)
    create index(:urls, [:original_url])
  end
end
