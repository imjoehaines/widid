module Main exposing (..)

import Html exposing (Html, div, p, text, main_, header, h1, form, input, ul, li, span, a)
import Html.Attributes exposing (class, placeholder, value, href, classList)
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
    , currentPage : Int
    , totalPages : Int
    }


initialModel : Model
initialModel =
    { newThing = ""
    , things = []
    , currentPage = 1
    , totalPages = 1
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
    | NextPage
    | PreviousPage


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
            let
                pages =
                    ceiling (((toFloat (List.length model.things) + 1)) / (toFloat itemsPerPage))
            in
                ( { model
                    | newThing = ""
                    , things = [ makeThing model time ] ++ model.things
                    , totalPages = pages
                  }
                , Cmd.none
                )

        NextPage ->
            if model.currentPage == model.totalPages then
                ( model, Cmd.none )
            else
                ( { model | currentPage = model.currentPage + 1 }, Cmd.none )

        PreviousPage ->
            if model.currentPage == 1 then
                ( model, Cmd.none )
            else
                ( { model | currentPage = model.currentPage - 1 }, Cmd.none )

        ClearThings ->
            ( { model | things = [], currentPage = 1, totalPages = 1 }, Cmd.none )


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
            , ul [ class "list" ] (List.map listItem (List.take itemsPerPage (List.drop (itemsPerPage * (model.currentPage - 1)) model.things)))
            , clearLink (List.length model.things)
            , pagination model
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


pagination : Model -> Html Msg
pagination model =
    if model.totalPages == 1 then
        text ""
    else
        div [ class "pagination" ]
            [ p []
                [ a
                    [ classList
                        [ ( "button", True )
                        , ( "disabled", model.currentPage == 1 )
                        ]
                    , href "#"
                    , onClick PreviousPage
                    ]
                    [ text "Previous" ]
                ]
            , p []
                [ text ("Page " ++ (toString model.currentPage) ++ " of " ++ (toString model.totalPages))
                ]
            , p []
                [ a
                    [ classList
                        [ ( "button", True )
                        , ( "disabled", model.currentPage == model.totalPages )
                        ]
                    , href "#"
                    , onClick NextPage
                    ]
                    [ text "Next" ]
                ]
            ]
