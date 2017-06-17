module Main exposing (..)

import Http
import HttpBuilder
import Html exposing (Html, div, p, text, main_, header, h1, form, input, ul, li, span, a)
import Html.Attributes exposing (class, placeholder, value, href, classList)
import Html.Events exposing (onSubmit, onInput, onClick)
import Time exposing (Time)
import Time.Format exposing (format)
import Json.Encode
import Json.Decode exposing (Decoder, int, float, string, list, field)
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
    { id : Int
    , text : String
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
        request =
            Http.get "/things" thingListDecoder
    in
        Http.send LoadThings request


thingListDecoder : Decoder (List Thing)
thingListDecoder =
    list thingDecoder


thingDecoder : Decoder Thing
thingDecoder =
    decode Thing
        |> required "id" int
        |> required "text" string
        |> custom (field "time" float |> Json.Decode.andThen unixSecondsToUnixMilisecondsDecoder)


unixSecondsToUnixMilisecondsDecoder : Time -> Decoder Time
unixSecondsToUnixMilisecondsDecoder time =
    time
        * 1000
        |> Json.Decode.succeed


thingIdDecoder : Decoder ThingId
thingIdDecoder =
    field "id" int


newThingEncoder : String -> Json.Encode.Value
newThingEncoder text =
    Json.Encode.object
        [ ( "text", Json.Encode.string text ) ]



-- UPDATE


type alias ThingId =
    Int


type Msg
    = Input String
    | AddThing
    | AddThingRequest (Result Http.Error Thing)
    | LoadThings (Result Http.Error (List Thing))
    | DeleteThing ThingId
    | DeleteThingRequest (Result Http.Error ThingId)


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
                ( model, createThing model.newThing )

        AddThingRequest (Ok thing) ->
            ( { model | things = thing :: model.things, newThing = "" }, Cmd.none )

        AddThingRequest (Err error) ->
            Debug.crash (toString error)

        DeleteThing id ->
            ( model, deleteThing id )

        DeleteThingRequest (Ok id) ->
            let
                things =
                    List.filter (\thing -> thing.id /= id) model.things
            in
                ( { model | things = things }, Cmd.none )

        DeleteThingRequest (Err error) ->
            Debug.crash (toString error)


createThing : String -> Cmd Msg
createThing text =
    HttpBuilder.post "/things"
        |> HttpBuilder.withExpect (Http.expectJson thingDecoder)
        |> HttpBuilder.withJsonBody (newThingEncoder text)
        |> HttpBuilder.send AddThingRequest


deleteThing : ThingId -> Cmd Msg
deleteThing id =
    let
        url =
            "/things/" ++ toString id
    in
        HttpBuilder.delete url
            |> HttpBuilder.withExpect (Http.expectJson thingIdDecoder)
            |> HttpBuilder.send DeleteThingRequest


makeThing : Model -> Time -> Thing
makeThing model time =
    { id = 1
    , text = model.newThing
    , time = time
    }



-- VIEW


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
            ]
        ]


listItem : Thing -> Html Msg
listItem thing =
    li []
        [ p [ class "text" ]
            [ text thing.text
            , a [ class "icon icon--delete", href "#", onClick (DeleteThing thing.id) ] [ text "×" ]
            , span [ class "time" ] [ text (format "%H:%M" thing.time) ]
            ]
        ]
