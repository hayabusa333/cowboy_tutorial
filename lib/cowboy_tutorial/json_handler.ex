defmodule CowboyTutorial.JsonHandler do
  import Ecto.Query

  def init(req, opts) do
    method = :cowboy_req.method(req)
    id = :cowboy_req.binding(:id, req)
    {:ok, resp} = json_respons(method, id, req)
    {:ok, resp, opts}
  end

  def json_respons("GET", id, req) do
    headers = %{"content-type" => "application/json"}

    user = CowboyTutorial.Repo.get!(CowboyTutorial.Models.User, id)
    body = Poison.Encoder.encode( %{name: user.name, email: user.email}, [])
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

end
