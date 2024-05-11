defmodule UrlShortener.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias UrlShortener.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import UrlShortener.DataCase
    end
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  # Setup all tests in this case to use the sandbox
  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(UrlShortener.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(UrlShortener.Repo, {:shared, self()})
    end

    :ok
  end

end
