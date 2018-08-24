module Widid.Types exposing (Msg(..), Thing, ThingId)

import Http
import Time


type alias Thing =
    { id : ThingId
    , text : String
    , time : Time.Posix
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
    | SetTimeZone Time.Zone
