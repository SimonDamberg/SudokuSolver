import System.Environment
import System.Random
import System.Exit
import Graphics.Gloss
import Graphics.Gloss.Data.Color
import Graphics.Gloss.Interface.IO.Game
import System.Random 
import SudokuSolver

n :: Int
n = 9

screenWidth :: Int
screenWidth = 720

screenHeight :: Int
screenHeight = 720

cellWidth :: Float
cellWidth = fromIntegral screenWidth / fromIntegral n

cellHeight :: Float
cellHeight = (fromIntegral screenHeight / fromIntegral n)

fixedColor = makeColorI 53 152 55 255

randSudokuBoard x boardList = return $ makeBoard $ head $ drop x boardList

main :: IO ()
main = do
  boardFile <- readFile "sudoku17.txt"
  let boards = lines boardFile
  randInt <- randomRIO (1, 49000) :: IO Int
  board <- (randSudokuBoard randInt boards)
  playIO FullScreen white 30 board displayBoardOnGrid eventBoard floatBoard
  
eventBoard event board = case event of
  EventKey (SpecialKey KeySpace) _ _ _ -> case solve board of
                    Just a -> return a
                    _ -> return board
  EventKey (Char 'r') Down _ _ -> fixNewBoard
  EventKey (SpecialKey KeyEsc) _ _ _ -> exitSuccess
  _ -> return board

fixNewBoard = do
  boardFile <- readFile "sudoku17.txt"
  let boards = lines boardFile
  randInt <- randomRIO (1, 49000) :: IO Int
  board <- (randSudokuBoard randInt boards)
  return board
                        
floatBoard float board = return board
    
displayBoardOnGrid :: Board -> IO Picture
displayBoardOnGrid board = return (translate (fromIntegral screenWidth * (-0.5)) (fromIntegral screenHeight * (-0.5)) (pictures ((displayBoardOnGrid' (zip [0..80] $ concat board)) ++ [gridBoard])))

displayBoardOnGrid' :: [(Int, Cell)] -> [Picture]
displayBoardOnGrid' [] = []
displayBoardOnGrid' (x:xs) = [displayCell x] ++  displayBoardOnGrid' xs

displayCell (i, val) =
  case val of
    Fixed num -> translate (((fromIntegral (i `mod` 9) :: Float) * cellWidth) + 17) (((fromIntegral (8 - (i `div` 9)) :: Float) * cellHeight) + 9.5) (color fixedColor $ scale 0.60 0.60 $ text $ show num)
    _         -> Blank

gridBoard :: Picture
gridBoard =
  pictures
  $ concatMap (\i -> [ line [ (i * cellWidth, 0.0)
                            , (i * cellWidth, fromIntegral screenHeight)
                            ]
                     , line [ (0.0,                      i * cellHeight)
                            , (fromIntegral screenWidth, i * cellHeight)
                            ]
                     ])
  [0.0..fromIntegral n]

  
{-
main :: IO ()
main = backgroundColor 30 initialSolver boardAsPicture transfromSolver (const id)



boardAsUnsolved board = Blank

boardAsSolved solved board = Blank

startValues :: Board -> Picture
startValues = undefined

solvedValues :: Board -> Picture
solvedValues = undefined

boardGrid :: Board -> Picture

boardAsPicture board =
  pictures []



boardAsSolvingPicture board =

boardAsPicture board = Blank

snapPictureToCell picture (row, column) = translate x y picture
  where x = fromIntegral column * cellWidth + cellWidth * 0.5
        y = fromIntegral row * cellHeight + cellHeight * 0.5

possibleCell :: Picture
possibleCell = Blank

fixedCell :: Picture
fixdCell = Blank

cellsOfBoard :: (Board, Board) -> Cell -> Picture -> Picture

cellsOfBoard :: Board -> Cell -> Picture -> Picture
cellsOfBoard board cell cellPicture =
  pictures
  $ map (snapPictureToCell cellPicture . fst)
  $ filter (\(_,e) -> e == cell  
  $ assoc board

possibleCellsOfBoard :: Board -> Picture
possibleCellsOfBoard = cellsOfBoard board (Possible [Int]) possibleCell


fixedCellsOfBoard :: Board -> Picture
fixedCellsOfBoard = cellsOfBoard board (Fixed Int) fixedCell

boardAsSolvedPicture solved = color (boardAsPicture board)

solverAsPicture :: SudokuSolver -> Picture
solverAsPicture solve =
  case solverBoard solve of
    Unsolved -> boardAsSolvingPicture (solverBoard solve)
    Solved board -> boardAsSolvedPicture board (gameBoard solve)


-}
