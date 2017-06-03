module Main exposing (..)

import Html exposing (Html, div, p, text, main_, header, h1, form, input, ul, li, span, a)
import Html.Attributes exposing (class, placeholder, value, href)
import Html.Events exposing (onSubmit, onInput, onClick)
import Task
import Time exposing (Time)
import Time.Format exposing (format)


main : Program Never Model Msg
main =
    Html.program
        { subscriptions = subscriptions
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
    ( initialModel, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE


type Msg
    = Input String
    | AddThing
    | AddThingWithTime Time
    | ClearThings


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
                , things = model.things ++ [ makeThing model time ]
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
            , if List.length model.things == 0 then
                text ""
              else
                a [ class "button", href "#", onClick ClearThings ] [ text "Clear list" ]
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
