module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode

-- message type

type alias User =
  { name  : String
  , email : String
  }

type alias Users =
  { listUsers : List User }

type Msg =
  LoadUsersData (Result Http.Error (List User))

init : ( Users, Cmd Msg )
init =
  ( { listUsers = [] }
  , sendRequest
  )

-- View

view : Users -> Html Msg
view users =
    div []
        (List.map renderUser users.listUsers)

renderUser : User -> Html msg
renderUser user =
    div []
        [ strong [] [ text "Name:" ] 
        , text user.name
        , strong [] [ text "Email:" ]
        , text user.email
        ]

-- update

update : Msg -> Users -> ( Users, Cmd Msg )
update msg users =
  case msg of
    LoadUsersData ( Ok newUsers ) ->
      ( { users | listUsers = newUsers }, Cmd.none )
    LoadUsersData ( Err _ ) ->
      ( { users | listUsers = [ {name = "err", email = "err"} ], Cmd.none )

-- subscriptions

subscriptions : Users -> Sub Msg
subscriptions user =
    Sub.none

-- MAIN

main : Program Never Users Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- decoder

nameDecoder =
  ( Decode.field "name" Decode.string )

emailDecoder =
  ( Decode.field "email" Decode.string )

userDecoder =
  Decode.map2 User nameDecoder emailDecoder 

usersDecoder =
  Decode.list userDecoder


-- request 
getUsersUrl : String
getUsersUrl =
  "http://localhost:4000/api/users/"

getUsers : Http.Request (List User)
getUsers =
  Http.get getUsersUrl usersDecoder

sendRequest : Cmd Msg
sendRequest =
  Http.send LoadUsersData getUsers
