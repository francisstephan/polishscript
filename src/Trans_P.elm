module Trans_P exposing (transl)

import Dict

latPol = Dict.fromList [ ("à" , "ą") 
                        , ("ç" , "ć")
                        , ("è" , "ę") 
                        , ("ù" , "ł")
                        , ("ñ" , "ń") 
                        , ("_" , "") -- filter _
                        ] -- useful on keyboards containing x, ù, à

latPol_= Dict.fromList [ ("a" , "ą")
                        , ("c" , "ć")
                        , ("e" , "ę") 
                        , ("l" , "ł")
                        , ("n" , "ń")
                        , ("o" , "ó")
                        , ("s" , "ś") 
                        , ("z" , "ź")
                        , ("r" , "ż") 
                        , ("A" , "Ą")
                        , ("C" , "Ć")
                        , ("E" , "Ę")
                        , ("L" , "Ł") 
                        , ("N" , "Ń")
                        , ("O" , "Ó")
                        , ("S" , "Ś")
                        , ("Z" , "Ź")
                        , ("R" , "Ż ")
                        ]

subst : String -> (Dict.Dict String String) -> String
subst car dict =
  Maybe.withDefault car (Dict.get car dict)

subst_ : (String,String) -> String
subst_ dble =
  let
     (carac, sub) = dble
  in
    if sub == "_" then subst carac latPol_ else subst carac latPol

szip : String -> List (String,String)
szip s =
  let
    ls = s |> String.toList |> List.map String.fromChar
  in
    List.map2 Tuple.pair ls ("&" :: ls)

transl : String -> String
transl chaine =
  szip chaine
   |> List.map subst_
   |> List.foldr (++) ""
