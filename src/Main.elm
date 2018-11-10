import Browser
import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


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
  = MoveRight
  | MoveLeft

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MoveRight ->
      ( { model | xPos = model.xPos + 5 }, Cmd.none )

    MoveLeft ->
      ( { model | xPos = model.xPos - 5 }, Cmd.none )

--SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

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
