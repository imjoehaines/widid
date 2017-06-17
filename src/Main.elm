module Main exposing (..)

import Http
import Html exposing (Html, div, p, text, main_, header, h1, form, input, ul, li, span, a)
import Html.Attributes exposing (class, placeholder, value, href, classList)
import Html.Events exposing (onSubmit, onInput, onClick)
import Task
import Time exposing (Time)
import Time.Format exposing (format)
import Json.Decode exposing (Decoder, float, string, list, field)
import Json.Decode.Pipeline exposing (decode, required, custom)


main : Program Never Model Msg
main =
    Html.program
        { subscriptions = (\_ -> Sub.none)
        , view = view
        , update = update
        , init = init
        }



-- MODEL


type alias Thing =
    { text : String
    , time : Time
    }


type alias Model =
    { newThing : String
    , things : List Thing
    }


initialModel : Model
initialModel =
    { newThing = ""
    , things = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getInitialData )


getInitialData : Cmd Msg
getInitialData =
    let
        url =
            "/things"

        request =
            Http.get url thingListDecoder
    in
        Http.send LoadThings request


thingListDecoder : Decoder (List Thing)
thingListDecoder =
    list thingDecoder


thingDecoder : Decoder Thing
thingDecoder =
    decode Thing
        |> required "text" string
        |> custom (field "time" float |> Json.Decode.andThen unixSecondsToUnixMilisecondsDecoder)


unixSecondsToUnixMilisecondsDecoder : Float -> Decoder Float
unixSecondsToUnixMilisecondsDecoder time =
    time
        * 1000
        |> Json.Decode.succeed



-- UPDATE


type Msg
    = Input String
    | AddThing
    | AddThingWithTime Time
    | ClearThings
    | LoadThings (Result Http.Error (List Thing))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadThings (Ok things) ->
            ( { model | things = things }, Cmd.none )

        LoadThings (Err error) ->
            Debug.crash (toString error)

        Input text ->
            ( { model | newThing = text }, Cmd.none )

        AddThing ->
            if String.trim model.newThing == "" then
                ( model, Cmd.none )
            else
                ( model
                , Task.perform AddThingWithTime Time.now
                )

        AddThingWithTime time ->
            ( { model
                | newThing = ""
                , things = [ makeThing model time ] ++ model.things
              }
            , Cmd.none
            )

        ClearThings ->
            ( { model | things = [] }, Cmd.none )


makeThing : Model -> Time -> Thing
makeThing model time =
    { text = model.newThing
    , time = time
    }



-- VIEW


itemsPerPage : Int
itemsPerPage =
    10


view : Model -> Html Msg
view model =
    div [ class "body" ]
        [ div [ class "container" ]
            [ header [ class "heading" ]
                [ h1 [ class "main-heading" ] [ text "widid" ]
                , form [ onSubmit AddThing ]
                    [ input [ class "input", placeholder "…", value model.newThing, onInput Input ] []
                    ]
                ]
            , ul [ class "list" ] (List.map listItem model.things)
            , clearLink (List.length model.things)
            ]
        ]


listItem : Thing -> Html Msg
listItem thing =
    li []
        [ p [ class "text" ]
            [ text thing.text
            , span [ class "time" ] [ text (format "%H:%M" thing.time) ]
            ]
        ]


clearLink : Int -> Html Msg
clearLink count =
    if count == 0 then
        text ""
    else
        a [ class "button", href "#", onClick ClearThings ] [ text "Clear list" ]
