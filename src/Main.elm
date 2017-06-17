module Main exposing (..)

import Html exposing (Html, div, p, text, main_, header, h1, form, input, ul, li, span, a)
import Html.Attributes exposing (class, placeholder, value, href, classList)
import Html.Events exposing (onSubmit, onInput, onClick)
import Time.Format exposing (format)
import Widid.Types exposing (Thing, ThingId, Msg(..))
import Widid.Requests


main : Program Never Model Msg
main =
    Html.program
        { subscriptions = (\_ -> Sub.none)
        , view = view
        , update = update
        , init = init
        }



-- MODEL


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
    ( initialModel, Widid.Requests.all )



-- UPDATE


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
                ( model, Widid.Requests.create model.newThing )

        AddThingRequest (Ok thing) ->
            ( { model | things = thing :: model.things, newThing = "" }, Cmd.none )

        AddThingRequest (Err error) ->
            Debug.crash (toString error)

        DeleteThing id ->
            ( model, Widid.Requests.delete id )

        DeleteThingRequest (Ok id) ->
            let
                things =
                    List.filter (\thing -> thing.id /= id) model.things
            in
                ( { model | things = things }, Cmd.none )

        DeleteThingRequest (Err error) ->
            Debug.crash (toString error)



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
