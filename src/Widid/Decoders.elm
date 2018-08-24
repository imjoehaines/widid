module Widid.Decoders exposing (thing, thingId, thingList)

import Json.Decode exposing (Decoder, field, int, list, string)
import Json.Decode.Pipeline exposing (custom, required)
import Time
import Widid.Types exposing (Thing, ThingId)


thingList : Decoder (List Thing)
thingList =
    list thing


thing : Decoder Thing
thing =
    Json.Decode.succeed Thing
        |> required "id" int
        |> required "text" string
        |> custom (field "time" int |> Json.Decode.andThen unixSecondsToUnixMiliseconds)


unixSecondsToUnixMiliseconds : Int -> Decoder Time.Posix
unixSecondsToUnixMiliseconds time =
    Json.Decode.succeed (Time.millisToPosix (time * 1000))


thingId : Decoder ThingId
thingId =
    field "id" int
