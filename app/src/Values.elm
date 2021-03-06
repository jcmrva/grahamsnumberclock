module Values exposing (hour12, hour24, last500digits, mmss, pad2, positions, to2CharList, toGrid, toNbrPositions)

import Dict exposing (Dict, empty, insert)


last500digits : String
last500digits =
    "02425950695064738395657479136519351798334535362521430035401260267716226721604198106522631693551887803881448314065252616878509555264605107117200099709291249544378887496062882911725063001303622934916080254594614945788714278323508292421020918258967535604308699380168924988926809951016905591995119502788717830837018340236474548882222161573228010132974509273445945043433009010969280253527518332898844615089404248265018193851562535796399618993967905496638003222348723967018485186439059104575627262464195387"


positions : String -> List String -> Dict String (List Int)
positions gn rng =
    let
        nbrPositions nbr =
            String.indices nbr gn

        toDict strList dict =
            case strList of
                h :: t ->
                    toDict t (Dict.insert h (nbrPositions h) dict)

                [] ->
                    dict
    in
    toDict rng Dict.empty


toNbrPositions : List Int -> Dict String (List Int)
toNbrPositions i =
    i
        |> to2CharList
        |> positions ("...." ++ last500digits)


toGrid : Int -> List ( Int, String ) -> List (List ( Int, String ))
toGrid width numbers =
    let
        getPart part =
            List.take width part

        drop =
            List.drop width

        toGrid_ part_ lst width_ =
            if List.isEmpty part_ then
                lst

            else
                toGrid_ (drop part_) (getPart part_ :: lst) width_
    in
    toGrid_ numbers [] width
        |> List.reverse


hour12 : List Int
hour12 =
    List.range 1 12


hour24 : List Int
hour24 =
    List.range 0 23


mmss : List Int
mmss =
    List.range 0 59


pad2 : String -> String
pad2 n =
    if String.length n == 1 then
        "0" ++ n

    else
        n


to2CharList : List Int -> List String
to2CharList l =
    List.map String.fromInt l
        |> List.map pad2
