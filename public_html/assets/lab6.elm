import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)

main =
    Browser.sandbox {init=init, view=view, update=update}

type alias Model = {str1:String, str2:String}
init : Model
init = {str1="", str2=""}
       
type Msg = Update1 String | Update2 String

update : Msg -> Model -> Model
update msg model =
    case msg of
         Update1 newStr ->
             {model | str1 = newStr}
         Update2 newStr ->
             {model | str2 = newStr}

view : Model -> Html Msg
view model =
    div []
        [
         input [placeholder "String 1", value model.str1, onInput Update1] [],
         input [placeholder "String 2", value model.str2, onInput Update2] [],
         div [] [text (String.join " " [model.str1, ":", model.str2])]
        ]


