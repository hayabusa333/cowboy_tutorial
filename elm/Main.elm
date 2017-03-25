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

type Msg =
  LoadUserData ( Result Http.Error User )
  | Name String
  | Email String

init : ( User, Cmd Msg )
init =
  ( { name = "empty", email = "empty" }
  , sendRequest
  )

-- View

view : User -> Html Msg
view user =
    div []
        [ strong [] [ text "Name:" ] 
        , text user.name
        , strong [] [ text "Email:" ]
        , text user.email
        ]

-- update

update : Msg -> User -> ( User, Cmd Msg )
update msg user =
  case msg of
    LoadUserData ( Ok newUser ) ->
      ( newUser, Cmd.none )
    LoadUserData ( Err _ ) ->
      ( user, Cmd.none )
    Name name ->
      ( { user | name = name }, Cmd.none )
    Email email ->
      ( { user | email = email }, Cmd.none )

-- subscriptions

subscriptions : User -> Sub Msg
subscriptions user =
    Sub.none

-- MAIN

main : Program Never User Msg
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

-- request 
getUserUrl : String
getUserUrl =
  "http://localhost:4000/api/users/"

getUser : Http.Request User
getUser =
  Http.get getUserUrl userDecoder

sendRequest : Cmd Msg
sendRequest =
  Http.send LoadUserData getUser 
