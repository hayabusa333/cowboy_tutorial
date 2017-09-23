defmodule CowboyTutorial.JsonHandler do
  import Ecto.Query

  def init(req, opts) do
    method = :cowboy_req.method(req)
    id = :cowboy_req.binding(:id, req)
    {:ok, resp} = json_respons(method, req)
    {:ok, resp, opts}
  end

  def json_respons("GET", req) do
    headers = %{"content-type" => "application/json"}

    query = from c in CowboyTutorial.Models.User, select: c
    users = CowboyTutorial.Repo.all(query)
    body = Poison.Encoder.encode(Enum.map(users, &(%{name: &1.name, email: &1.email})), [])
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

end
