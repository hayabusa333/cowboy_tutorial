defmodule CowboyTutorial.HttpHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:static_html, req)
    {:ok, resp} = html_respons(method, param, req)
    {:ok, resp, opts}
  end

  def html_read(param) do
    case File.read "priv/static/html/#{param}.html" do
      {:ok, file} ->
        body = file
        {200, body}
      {:error, _} ->
        body = ""
        {404, body}
    end
  end

  def html_respons("GET", param, req) do
    headers = %{"content-type" => "text/html"}
    {states, body} = html_read(param)
    {:ok, resp} = :cowboy_req.reply(states, headers, body, req)
  end

end
