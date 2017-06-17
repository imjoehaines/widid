module Widid.Requests exposing (all, create, delete)

import Http
import HttpBuilder
import Widid.Decoders
import Widid.Encoders
import Widid.Types exposing (Thing, ThingId, Msg(..))


all : Cmd Msg
all =
    HttpBuilder.get "/things"
        |> HttpBuilder.withExpect (Http.expectJson Widid.Decoders.thingList)
        |> HttpBuilder.send LoadThings


create : String -> Cmd Msg
create text =
    HttpBuilder.post "/things"
        |> HttpBuilder.withExpect (Http.expectJson Widid.Decoders.thing)
        |> HttpBuilder.withJsonBody (Widid.Encoders.newThing text)
        |> HttpBuilder.send AddThingRequest


delete : ThingId -> Cmd Msg
delete id =
    let
        url =
            "/things/" ++ toString id
    in
        HttpBuilder.delete url
            |> HttpBuilder.withExpect (Http.expectJson Widid.Decoders.thingId)
            |> HttpBuilder.send DeleteThingRequest
