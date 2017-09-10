module Dialog exposing (Dialog, toDialog, isDone, nextLine, currentLine)


type alias Dialog =
    { lines : List String
    , index : Int
    }


toDialog : Int -> String -> Dialog
toDialog maxLineLength text =
    Dialog (toLines maxLineLength text) 0


isDone : Dialog -> Bool
isDone { lines, index } =
    index >= List.length lines


nextLine : Dialog -> Dialog
nextLine dialog =
    if isDone dialog then
        dialog
    else
        { dialog | index = dialog.index + 1 }


currentLine : Dialog -> Maybe String
currentLine { lines, index } =
    lines
        |> List.drop index
        |> List.head



-- private


toLines : Int -> String -> List String
toLines maxLineLength text =
    let
        words : List String
        words =
            text
                |> String.split " "
                |> List.filter (not << String.isEmpty)
    in
        List.foldl
            (\word { lines, line } ->
                if String.length (line ++ " " ++ word) > maxLineLength then
                    { lines = line :: lines
                    , line = word
                    }
                else
                    { lines = lines
                    , line = line ++ " " ++ word
                    }
            )
            { lines = [], line = "" }
            words
            |> (\{ lines, line } -> line :: lines)
            |> List.reverse
