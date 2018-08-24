module Widid.Encoders exposing (editThing, newThing)

import Json.Encode
import Time
import Widid.Types exposing (Thing)


newThing : String -> Json.Encode.Value
newThing text =
    Json.Encode.object
        [ ( "text", Json.Encode.string text ) ]


editThing : Thing -> Json.Encode.Value
editThing thing =
    Json.Encode.object
        [ ( "id", Json.Encode.int thing.id )
        , ( "text", Json.Encode.string thing.text )
        , ( "time", Json.Encode.int (Time.posixToMillis thing.time) )
        ]
