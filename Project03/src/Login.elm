module Main exposing (main)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Utilities.Border as Border
import Bootstrap.Utilities.Spacing as Spacing
import Browser
import Browser.Navigation exposing (load)
import Html exposing (Html, br, button, div, h1, input, p, text)
import Html.Attributes exposing (align, autofocus, disabled, hidden, placeholder, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as JDecode
import Json.Encode as JEncode
import String

rootUrl = "http://www.mac1xa3.ca/e/rossil1/Project03/"

type alias Model =
    { user : String
    , pass : String
    , passChk : String
    , createUser : Bool -- Commenting testing -> here
    , notif : String
    }

encode : Model -> JEncode.Value
encode model =
    JEncode.object
        [ ( "username", JEncode.string model.user )
        , ( "password", JEncode.string model.pass )
        , ( "login", JEncode.bool <| not model.createUser )
        ]

jsonPost : Model -> Cmd Msg
jsonPost model =
    Http.post
        { url = rootUrl ++ "login/"
        , body = Http.jsonBody <| encode model
        , expect = Http.expectString Response
        }

initialModel : () -> ( Model, Cmd Msg )
initialModel _ =
    ( { user = "", pass = "", passChk = "", createUser = False, notif = "" }, Cmd.none )

type Msg
    = DeltaUser String
    | DeltaPass String
    | DeltaPassChk String
    | CreateAcc
    | Verify
    | Response (Result Http.Error String)

accVerify : Model -> (Model, Cmd Msg)
accVerify model =
    case model.createUser of
        True ->
            if model.user == "" then
                ({ model | notif = "Please enter a username" }, Cmd.none)

            else if model.pass == "" then
                ({ model | notif = "Please enter a password" }, Cmd.none)

            else if model.pass /= model.passChk then
                ({ model | notif = "Passwords do not match, take a check and try again." }, Cmd.none)
            else
                ( model, jsonPost model )

        False ->
            if model.user == "" then
                ({ model | notif = "Please enter a username" }, Cmd.none)

            else if model.pass == "" then
                ({ model | notif = "Please enter a password" }, Cmd.none)

            else
                ( model, jsonPost model )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DeltaUser newUser ->
            ( { model | user = newUser }, Cmd.none )

        DeltaPass newPass ->
            ( { model | pass = newPass }, Cmd.none )

        DeltaPassChk newPassChk ->
            ( { model | passChk = newPassChk }, Cmd.none )

        Verify ->
            accVerify model

        CreateAcc ->
            ( { model
                | pass = ""
                , passChk = ""
                , notif = ""
                , createUser = not model.createUser
              }
            , Cmd.none
            )

        Response result ->
            case result of
                Ok "denied" ->
                    ( { model | notif = "Your access was denied. Check your info, or make an account." }, Cmd.none )

                Ok "usernameTaken" ->
                    ({model|notif="That username is taken. Pick another"},Cmd.none)
                Ok "accountCreated" ->
                    ({model|notif="Account created! Now go back and login."}, Cmd.none)
                Ok _ ->
                    ( model, load (rootUrl ++ "app/") )

                Err error ->
                    ( errorGet model error, Cmd.none )

view : Model -> Html Msg
view model =
    div [ align "center", Border.all ]
        [ h1 [ hidden model.createUser ] [ text "Login" ]
        , h1 [ hidden <| not model.createUser ] [ text "Create New Account" ]
        , CDN.stylesheet
        , Grid.container [ hidden model.createUser ]
            [ Grid.row [ Row.centerMd ]
                [ Grid.col [ Col.lg3 ] [ input [ type_ "text", onInput DeltaUser, placeholder "Username", value model.user ] [] ]
                , Grid.colBreak []
                , Grid.col [ Col.lg3 ] [ input [ type_ "password", onInput DeltaPass, placeholder "Password", Spacing.mt2, value model.pass ] [] ]
                , Grid.colBreak []
                ]
            , Grid.row [ Row.centerMd ]
                [ Grid.col []
                    [ button [ onClick Verify, Spacing.mr2, Spacing.mt3 ] [ text "Login" ]
                    , button [ onClick CreateAcc, Spacing.ml2, Spacing.mt3 ] [ text "Create Account" ]
                    ]
                ]
            ]

        -- CREATE USER CONTAINER BELOW --
        , Grid.container [ hidden <| not model.createUser ]
            [ Grid.row [ Row.centerMd ]
                [ Grid.col [ Col.lg3 ] [ input [ type_ "text", onInput DeltaUser, placeholder "Username", value model.user ] [] ]
                , Grid.colBreak []
                , Grid.col [ Col.lg3 ] [ input [ type_ "password", onInput DeltaPass, placeholder "Password", Spacing.mt2, value model.pass ] [] ]
                , Grid.colBreak []
                , Grid.col [ Col.lg3 ] [ input [ type_ "password", onInput DeltaPassChk, placeholder "Password Again", Spacing.mt2, value model.passChk ] [] ]
                ]
            , Grid.row [ Row.centerMd ]
                [ Grid.col []
                    [ button [ onClick CreateAcc, Spacing.mr1, Spacing.mt3 ] [ text "Back" ]
                    , button [ onClick Verify , Spacing.ml1, Spacing.mt3 ] [ text "Submit" ]
                    ]
                ]
            ]
        , p [ style "color" "#d01818" ] [ text model.notif ]
        ]

errorGet : Model -> Http.Error -> Model
errorGet model error =
    case error of
        Http.BadUrl url ->
            { model | notif = "bad url: " ++ url }

        Http.Timeout ->
            { model | notif = "Timeout!" }

        Http.NetworkError ->
            { model | notif = "Network Error!" }

        Http.BadStatus status ->
            { model | notif = "Bad Status: " ++ String.fromInt status }

        -- Http.BadStatus Int
        Http.BadBody resp ->
            { model | notif = "Bad Body: " ++ resp }

main : Program () Model Msg
main =
    Browser.element
        { init = initialModel
        , subscriptions = \_ -> Sub.none --subscriptions
        , view = view
        , update = update
        }
