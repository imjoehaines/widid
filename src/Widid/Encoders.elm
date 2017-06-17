module Widid.Encoders exposing (newThing)

import Json.Encode


newThing : String -> Json.Encode.Value
newThing text =
    Json.Encode.object
        [ ( "text", Json.Encode.string text ) ]
