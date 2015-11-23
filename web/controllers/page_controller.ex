defmodule Shopper.PageController do
  use Shopper.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
