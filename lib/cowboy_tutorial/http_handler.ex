defmodule CowboyTutorial.HttpHandler do
  def init(req, :user) do
    method = :cowboy_req.method(req)
    id = :cowboy_req.binding(:id, req)
    param = "show"
    path = "priv/static/html/user/"
    {:ok, resp} = html_respons(method, param, path, req)
    {:ok, resp, []}
  end

  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:static_html, req)
    path = "priv/static/html/"
    {:ok, resp} = html_respons(method, param, path, req)
    {:ok, resp, opts}
  end

  def html_read(param, path) do
    case File.read "#{path}#{param}.html" do
      {:ok, file} ->
        body = file
        {200, body}
      {:error, _} ->
        body = ""
        {404, body}
    end
  end

  def html_respons("GET", param, path, req) do
    headers = %{"content-type" => "text/html"}
    {states, body} = html_read(param, path)
    {:ok, resp} = :cowboy_req.reply(states, headers, body, req)
  end

end
