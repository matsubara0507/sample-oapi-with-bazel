{-
   ToDo App
   No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)

   The version of the OpenAPI document: 1.0.0

   NOTE: This file is auto generated by the openapi-generator.
   https://github.com/openapitools/openapi-generator.git

   DO NOT EDIT THIS FILE MANUALLY.

   For more info on generating Elm code, see https://eriktim.github.io/openapi-elm/
-}


module Api.Data exposing
    ( ToDo
    , encodeToDo
    , toDoDecoder
    )

import Api
import Dict
import Json.Decode
import Json.Encode


-- MODEL


type alias ToDo =
    { id : Int
    , title : String
    , done : Bool
    }


-- ENCODER


encodeToDo : ToDo -> Json.Encode.Value
encodeToDo =
    encodeObject << encodeToDoPairs


encodeToDoWithTag : ( String, String ) -> ToDo -> Json.Encode.Value
encodeToDoWithTag (tagField, tag) model =
    encodeObject (encodeToDoPairs model ++ [ encode tagField Json.Encode.string tag ])


encodeToDoPairs : ToDo -> List EncodedField
encodeToDoPairs model =
    let
        pairs =
            [ encode "id" Json.Encode.int model.id
            , encode "title" Json.Encode.string model.title
            , encode "done" Json.Encode.bool model.done
            ]
    in
    pairs


-- DECODER


toDoDecoder : Json.Decode.Decoder ToDo
toDoDecoder =
    Json.Decode.succeed ToDo
        |> decode "id" Json.Decode.int 
        |> decode "title" Json.Decode.string 
        |> decode "done" Json.Decode.bool 




-- HELPER


type alias EncodedField =
    Maybe ( String, Json.Encode.Value )


encodeObject : List EncodedField -> Json.Encode.Value
encodeObject =
    Json.Encode.object << List.filterMap identity


encode : String -> (a -> Json.Encode.Value) -> a -> EncodedField
encode key encoder value =
    Just ( key, encoder value )


encodeNullable : String -> (a -> Json.Encode.Value) -> Maybe a -> EncodedField
encodeNullable key encoder value =
    Just ( key, Maybe.withDefault Json.Encode.null (Maybe.map encoder value) )


maybeEncode : String -> (a -> Json.Encode.Value) -> Maybe a -> EncodedField
maybeEncode key encoder =
    Maybe.map (Tuple.pair key << encoder)


maybeEncodeNullable : String -> (a -> Json.Encode.Value) -> Maybe a -> EncodedField
maybeEncodeNullable =
    encodeNullable


decode : String -> Json.Decode.Decoder a -> Json.Decode.Decoder (a -> b) -> Json.Decode.Decoder b
decode key decoder =
    decodeChain (Json.Decode.field key decoder)


decodeLazy : (a -> c) -> String -> Json.Decode.Decoder a -> Json.Decode.Decoder (c -> b) -> Json.Decode.Decoder b
decodeLazy f key decoder =
    decodeChainLazy f (Json.Decode.field key decoder)


decodeNullable : String -> Json.Decode.Decoder a -> Json.Decode.Decoder (Maybe a -> b) -> Json.Decode.Decoder b
decodeNullable key decoder =
    decodeChain (maybeField key decoder Nothing)


decodeNullableLazy : (Maybe a -> c) -> String -> Json.Decode.Decoder a -> Json.Decode.Decoder (c -> b) -> Json.Decode.Decoder b
decodeNullableLazy f key decoder =
    decodeChainLazy f (maybeField key decoder Nothing)


maybeDecode : String -> Json.Decode.Decoder a -> Maybe a -> Json.Decode.Decoder (Maybe a -> b) -> Json.Decode.Decoder b
maybeDecode key decoder fallback =
    -- let's be kind to null-values as well
    decodeChain (maybeField key decoder fallback)


maybeDecodeLazy : (Maybe a -> c) -> String -> Json.Decode.Decoder a -> Maybe a -> Json.Decode.Decoder (c -> b) -> Json.Decode.Decoder b
maybeDecodeLazy f key decoder fallback =
    -- let's be kind to null-values as well
    decodeChainLazy f (maybeField key decoder fallback)


maybeDecodeNullable : String -> Json.Decode.Decoder a -> Maybe a -> Json.Decode.Decoder (Maybe a -> b) -> Json.Decode.Decoder b
maybeDecodeNullable key decoder fallback =
    decodeChain (maybeField key decoder fallback)


maybeDecodeNullableLazy : (Maybe a -> c) -> String -> Json.Decode.Decoder a -> Maybe a -> Json.Decode.Decoder (c -> b) -> Json.Decode.Decoder b
maybeDecodeNullableLazy f key decoder fallback =
    decodeChainLazy f (maybeField key decoder fallback)


maybeField : String -> Json.Decode.Decoder a -> Maybe a -> Json.Decode.Decoder (Maybe a)
maybeField key decoder fallback =
    let
        fieldDecoder =
            Json.Decode.field key Json.Decode.value

        valueDecoder =
            Json.Decode.oneOf [ Json.Decode.map Just decoder, Json.Decode.null fallback ]

        decodeObject rawObject =
            case Json.Decode.decodeValue fieldDecoder rawObject of
                Ok rawValue ->
                    case Json.Decode.decodeValue valueDecoder rawValue of
                        Ok value ->
                            Json.Decode.succeed value

                        Err error ->
                            Json.Decode.fail (Json.Decode.errorToString error)

                Err _ ->
                    Json.Decode.succeed fallback
    in
    Json.Decode.value
        |> Json.Decode.andThen decodeObject


decodeChain : Json.Decode.Decoder a -> Json.Decode.Decoder (a -> b) -> Json.Decode.Decoder b
decodeChain =
    Json.Decode.map2 (|>)


decodeChainLazy : (a -> c) -> Json.Decode.Decoder a -> Json.Decode.Decoder (c -> b) -> Json.Decode.Decoder b
decodeChainLazy f =
    decodeChain << Json.Decode.map f