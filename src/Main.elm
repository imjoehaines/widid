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
    , maybeEditThing : Maybe Thing
    }


initialModel : Model
initialModel =
    { newThing = ""
    , things = []
    , maybeEditThing = Nothing
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

        EditThing thing ->
            ( { model | maybeEditThing = Just thing }, Cmd.none )

        EditInput text ->
            case model.maybeEditThing of
                Nothing ->
                    ( model, Cmd.none )

                Just thingToEdit ->
                    let
                        editedThing =
                            { thingToEdit | text = text }
                    in
                        ( { model | maybeEditThing = Just editedThing }, Cmd.none )

        ConfirmEditThing editedThing ->
            ( model, Widid.Requests.edit editedThing )

        EditThingRequest (Ok editedThing) ->
            let
                things =
                    List.map (updateEditedThing editedThing) model.things
            in
                ( { model | things = things, maybeEditThing = Nothing }, Cmd.none )

        EditThingRequest (Err error) ->
            Debug.crash (toString error)

        CancelEdit ->
            ( { model | maybeEditThing = Nothing }, Cmd.none )


updateEditedThing : Thing -> Thing -> Thing
updateEditedThing editedThing thing =
    if thing.id == editedThing.id then
        editedThing
    else
        thing



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
            , ul [ class "list" ] (List.map (listItem model.maybeEditThing) model.things)
            ]
        ]


listItem : Maybe Thing -> Thing -> Html Msg
listItem maybeEditThing thing =
    li [ class "thing-row" ]
        (case maybeEditThing of
            Nothing ->
                renderThing thing

            Just editThing ->
                if editThing.id == thing.id then
                    renderEditThing editThing
                else
                    renderThing thing
        )


renderThing : Thing -> List (Html Msg)
renderThing thing =
    [ p [ class "text" ] [ text thing.text ]
    , span [ class "time" ] [ text (format "%H:%M" thing.time) ]
    , div [ class "icon-container" ]
        [ a [ class "icon icon--edit", href "#", onClick (EditThing thing) ] [ text "Edit" ]
        , a [ class "icon icon--delete", href "#", onClick (DeleteThing thing.id) ] [ text "Delete" ]
        ]
    ]


renderEditThing : Thing -> List (Html Msg)
renderEditThing thing =
    [ form [ class "edit-form", onSubmit (ConfirmEditThing thing) ]
        [ input [ class "input", onInput EditInput, value thing.text ] [] ]
    , div [ class "icon-container" ]
        [ a [ class "icon icon--save", href "#", onClick (ConfirmEditThing thing) ] [ text "Save" ]
        , a [ class "icon icon--cancel", href "#", onClick CancelEdit ] [ text "Cancel" ]
        ]
    ]
