import Data.List
import Data.Traversable
import Data.List.Split

data Cell = Fixed Int | Possible [Int] deriving (Show, Eq)

type Row = [Cell]

type Board = [Row]

{- finishedBoard board
Checks if all cells are filled with one value-}
finishedBoard :: Board -> Bool
finishedBoard board = undefined

{- makeBoard string
Creates a board with all possible values in cells from a string
-}
makeBoard :: String -> Maybe Board
makeBoard string
  |(length string) /= 81 = Nothing
  |otherwise = Just (map makeBoard' (chunksOf 9 string))
  where makeBoard' [] = []
        makeBoard' (x:xs)
          |x == '*' = [Possible [1..9]] ++ makeBoard' xs
          |otherwise = [Fixed (read [x] ::Int)] ++ makeBoard' xs

{- displayBoard board
Converts the board into graphical rows
-}
displayBoard :: Board -> String
displayBoard board = unlines (map displayBoard' board)
  where displayBoard' [] = []
        displayBoard' (x:xs) =
          case x of
          Fixed x -> show x ++ " " ++ displayBoard' xs
          _ -> "* " ++ displayBoard' xs

{- checkRow row val
Removes val from every other cell in row
-}
checkRow :: Row -> Cell -> Row
checkRow row val = undefined

{- checkSquare board val
Removes val from every other cell in the 3x3 square corresponding to val
-}
checkSquare :: Board -> Cell -> Board
checkSquare board val = undefined


