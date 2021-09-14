module Main exposing (main)

import Api
import Api.Data as Api
import Api.Request.Default as Api
import Browser as Browser
import Html as Html exposing (..)
import Html.Attributes exposing (attribute, checked, class, placeholder, style, type_)
import Html.Events exposing (onCheck, onClick, onInput)
import Http
import Octicons


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init initModel
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { todos : List Api.ToDo
    , title : String
    }


type Msg
    = FetchTodos (Result Http.Error (List Api.ToDo))
    | Reload
    | ChangeToDo Api.ToDo
    | Title String
    | PushPostButton String
    | PushDeleteButton Int


initModel : Model
initModel =
    { todos = [], title = "" }


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, sendApi FetchTodos Api.todosGet )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchTodos (Ok todos) ->
            ( { model | todos = todos }, Cmd.none )

        FetchTodos (Err _) ->
            ( { model | todos = [] }, Cmd.none )

        ChangeToDo todo ->
            ( model, sendApi (always Reload) (Api.todosTodoIdPut todo.id todo) )

        Title title ->
            ( { model | title = title }, Cmd.none )

        PushPostButton title ->
            ( model, sendApi (always Reload) (Api.todosPost { id = 0, title = title, done = False }) )

        PushDeleteButton todoId ->
            ( model, sendApi (always Reload) (Api.todosTodoIdDelete todoId) )

        Reload ->
            ( model, sendApi FetchTodos Api.todosGet )


sendApi : (Result Http.Error a -> msg) -> Api.Request a -> Cmd msg
sendApi toMsg req =
    req
        |> Api.withBasePath "/api"
        |> Api.send toMsg


view : Model -> Html Msg
view model =
    div [ class "my-3 mx-auto col-10" ]
        [ h1 [] [ text "ToDo List !!" ]
        , viewToDos model
        , viewPost model
        ]


viewToDos : Model -> Html Msg
viewToDos model =
    div [ class "border-bottom" ]
        [ ul [] (List.map viewTodo model.todos) ]


viewTodo : Api.ToDo -> Html Msg
viewTodo todo =
    li
        [ class "Box-row" ]
        [ label
            [ class "float-left py-2 pl-3" ]
            [ input
                [ type_ "checkbox"
                , checked todo.done
                , onCheck (\b -> ChangeToDo { todo | done = b })
                ]
                []
            ]
        , div
            [ class "float-left col-10 p-2 lh-condensed" ]
            [ div [ class "h4" ] [ text todo.title ] ]
        , button
            [ class "btn-link btn-danger", onClick (PushDeleteButton todo.id) ]
            [ Octicons.defaultOptions
                |> Octicons.size 16
                |> Octicons.class "octicon pr-1"
                |> Octicons.color ""
                |> Octicons.trashcan
            ]
        ]


viewPost : Model -> Html Msg
viewPost model =
    div []
        [ input
            [ class "form-control m-3"
            , type_ "text"
            , placeholder "Todo Title"
            , onInput Title
            ]
            []
        , span []
            [ button
                [ class "btn"
                , onClick (PushPostButton model.title)
                ]
                [ text "Add Todo" ]
            ]
        ]
