import Browser
import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Json.Decode as Decode
import Browser.Events as Events


--MAIN

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

--MODEL

type alias Model =
  { xPos : Int
    , yPos : Int
    , width : Int
    , height : Int
    , color : String
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model 600 600 50 20 "black", Cmd.none )

--UPDATE

type Msg
  = Move String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Move code ->
      if code == "39" then
        ({ model | xPos = model.xPos - 5 }, Cmd.none)
      else if code == "37" then
        ({ model | xPos = model.xPos + 5 }, Cmd.none)
      else
        ( model, Cmd.none )

--SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Events.onKeyDown (Decode.map Move keyDecoder)


--VIEW

view : Model -> Html Msg
view model =
  svg [ Svg.Attributes.width "1200", Svg.Attributes.height "1200" ] [
    drawBouncer model
  ]


drawBouncer : Model -> Svg Msg
drawBouncer model =
  rect [ x (String.fromInt model.xPos)
       , y (String.fromInt model.yPos)
       , Svg.Attributes.width (String.fromInt model.width)
       , Svg.Attributes.height (String.fromInt model.height)
       , color model.color ] []


keyDecoder : Decode.Decoder String
keyDecoder =
  Decode.field "key" Decode.string
