module Widid.Encoders exposing (newThing, editThing)

import Json.Encode
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
        , ( "time", Json.Encode.float thing.time )
        ]
