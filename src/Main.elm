module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick)
import Dialog exposing (Dialog)


exampleString : String
exampleString =
    """Hello world, the world is round and it's a great planet."""


type alias Model =
    { dialog : Dialog }


type Msg
    = NextLine


init : ( Model, Cmd Msg )
init =
    ( Model (Dialog.toDialog 10 exampleString), Cmd.none )


view : Model -> Html Msg
view model =
    case Dialog.currentLine model.dialog of
        Just line ->
            div []
                [ div [] [ text line ]
                , button [ onClick NextLine ] [ text ">" ]
                ]

        Nothing ->
            div [] [ text "No more lines" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NextLine ->
            ( { model | dialog = Dialog.nextLine model.dialog }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
