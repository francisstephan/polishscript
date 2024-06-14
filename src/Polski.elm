port module Polski exposing (main)

import Browser
import Html exposing (Html, Attribute, div, input, text, button, br, span)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Trans_P

-- MAIN
main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }

-- MODEL

type alias Model =
  { content : String
  }

type alias Flags = {} -- do not need flags

init : Flags -> ( Model, Cmd msg )
init _ =
  ( {content = "" }, Cmd.none)

-- UPDATE

type Msg
  = Change String | Reset | CopyToClipboard  | OpenDic

port copyToClip : String -> Cmd msg
port resetFocus : String -> Cmd msg
port openDic : String -> Cmd msg

update : Msg -> { content : String } -> ( { content : String }, Cmd Msg )
update msg model =
  case msg of
    Change newContent ->
      ({ model | content = newContent }, Cmd.none)
    Reset ->
      ({model | content = ""}, resetFocus "" )
    CopyToClipboard ->
      ( model, copyToClip "convert")
    OpenDic ->
      ( model, openDic "convert")

-- SUBSCRIPTIONS

subscriptions :  { content : String } -> Sub Msg
subscriptions _ = Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ span [style "font-weight" "bold"] [ text "Type on western keyboard :"]
    , button [ class "rebut", onClick Reset ] [ text "Reset" ]
    , button [ class "rebut", onClick CopyToClipboard ] [ text "Copy to clipboard" ]
    , button [ class "rebut", onClick OpenDic ] [ text "Look up in Reverso" ]
    , br [] []
    , input [ autofocus True, size 120, placeholder "Western characters", value model.content, onInput Change, id "entree" ] []
    , div [style "font-weight" "bold", style "margin-top" "12px"] [ text "Get polish text :"]
    , div [ id "convert", dir "ltr"] [ text (Trans_P.transl model.content) ]
    ]
