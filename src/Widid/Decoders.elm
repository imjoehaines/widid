module Widid.Decoders exposing (thingList, thing, thingId)

import Json.Decode exposing (Decoder, int, float, string, list, field)
import Json.Decode.Pipeline exposing (decode, required, custom)
import Time exposing (Time)
import Widid.Types exposing (Thing, ThingId)


thingList : Decoder (List Thing)
thingList =
    list thing


thing : Decoder Thing
thing =
    decode Thing
        |> required "id" int
        |> required "text" string
        |> custom (field "time" float |> Json.Decode.andThen unixSecondsToUnixMiliseconds)


unixSecondsToUnixMiliseconds : Time -> Decoder Time
unixSecondsToUnixMiliseconds time =
    time
        * 1000
        |> Json.Decode.succeed


thingId : Decoder ThingId
thingId =
    field "id" int
