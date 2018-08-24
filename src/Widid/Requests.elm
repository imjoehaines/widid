module Widid.Requests exposing (all, create, delete, edit)

import Http
import HttpBuilder
import Widid.Decoders
import Widid.Encoders
import Widid.Types exposing (Msg(..), Thing, ThingId)


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
    HttpBuilder.delete ("/things/" ++ String.fromInt id)
        |> HttpBuilder.withExpect (Http.expectJson Widid.Decoders.thingId)
        |> HttpBuilder.send DeleteThingRequest


edit : Thing -> Cmd Msg
edit thing =
    HttpBuilder.put ("/things/" ++ String.fromInt thing.id)
        |> HttpBuilder.withExpect (Http.expectJson Widid.Decoders.thing)
        |> HttpBuilder.withJsonBody (Widid.Encoders.editThing thing)
        |> HttpBuilder.send EditThingRequest
