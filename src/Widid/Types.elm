module Widid.Types exposing (Thing, ThingId, Msg(..))

import Http
import Time exposing (Time)


type alias Thing =
    { id : ThingId
    , text : String
    , time : Time
    }


type alias ThingId =
    Int


type Msg
    = Input String
    | AddThing
    | AddThingRequest (Result Http.Error Thing)
    | LoadThings (Result Http.Error (List Thing))
    | DeleteThing ThingId
    | DeleteThingRequest (Result Http.Error ThingId)
    | EditThing Thing
    | EditInput String
    | EditThingRequest (Result Http.Error Thing)
    | CancelEdit
    | ConfirmEditThing Thing
