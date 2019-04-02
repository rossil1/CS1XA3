import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import String exposing (String)
import Delay exposing (..)
import Debug
--import Random 

--generator : Random.Generator -> Int
--generator = Random.int 1 4
            
type Msg = Tick Float GetKeyState
      

    -- KeyPresses holds a list on inputs marked as WASD for dir., active
    -- Active reads which button should be illuminated 0 being null
    -- red being 1, and counting in a cw dir.
    -- State reads for the animations. 
type alias Model = {
      genOrder : List String  
      ,keyPresses : List String
      ,b1 : Float
      ,b2 : Float
      ,b3 : Float
      ,b4 : Float
      ,state : Int
      ,score : Int
      ,ready : Float
    }
    
     
-- States: 0 - Wait for start, 1 - generation turn pt1, 2 - generation turn pt2, 3 - player turn, -1 - gameover 
init = {genOrder=[],keyPresses=[],b1=0.5, b2=0.5, b3=0.5, b4=0.5,state=0,score=0, ready=0.0}

update : Msg -> Model -> Model
update msg model =
    case msg of            
        Tick ticks (keyToState, (arrowX, arrowY), (wasdX, wasdY)) ->
            if model.state == 3 then
                let ad = 7*wasdX
                    ws = wasdY
                    sel = ad + ws
                in
                    if sel == 1 then
                        case keyToState (Key "w") of
                            JustDown ->
                                {model | keyPresses = model.keyPresses ++ ["w"]
                                , b2=1.0
                                }
                            _ ->
                                    model
                    else if sel == -7 then
                         case keyToState (Key "a") of
                             JustDown ->
                                {model | keyPresses = model.keyPresses ++ ["a"]
                                , b1=1.0
                                }
                             _ ->
                                model
                    else if sel == -1 then
                         case keyToState (Key "s") of
                             JustDown ->
                                {model | keyPresses = model.keyPresses ++ ["s"]
                                , b4=1.0
                                }
                             _ ->
                                model
                    else if sel == 7 then
                         case keyToState (Key "d") of
                             JustDown ->
                                {model | keyPresses = model.keyPresses ++ ["d"]
                                , b3=1.0
                                }
                             _ ->
                                model
                    else
                         {model | b1=0.5,b2=0.5,b3=0.5,b4=0.5}
            else if model.state == 0 then      
                case keyToState (Space) of
                    JustDown ->
                        {model | state = 3, ready = 1}
                    _ ->
                        model
          --  else if model.state == 1 then
                     
            --        if roll == 1 then
              --          {model | genOrder = model.genOrder ++ ["a"]
                --        ,b1=1.0
                  --      ,state = 2
                   --     }
 --                   else if roll == 2 then
   --                    {model | genOrder = model.genOrder ++ ["w"]
    --                   ,b2=1.0
    --                    ,state = 2
      --                  }
        --            else if roll == 3 then
          --              {model | genOrder = model.genOrder ++ ["d"]
            --            ,b3=1.0
              --          ,state = 2
                --        }
 --                   else
   --                     {model | genOrder = model.genOrder ++ ["s"]
     --                   ,b4=1.0
       --                 ,state = 2
         --               }
                            
           else
               model
                            
view model =
         collage  500 500
             [circle 50 |> filled red |> makeTransparent model.b1 |> addOutline (solid 2) black |>  move (-180,0)
             ,circle 50 |> filled blue |> makeTransparent model.b2 |> addOutline (solid 2) black |> move (0,130)
             ,circle 50 |> filled green |> makeTransparent model.b3 |> addOutline (solid 2) black |> move (180,0)
             ,circle 50 |> filled yellow |> makeTransparent model.b4|> addOutline (solid 2) black |>move (0,-130) 
             ,text "Hit the Spacebar to start the game!"
             |> size 14
             |> filled black
             |> (makeTransparent  <| 1 - model.ready)
             |> move (-100,0)
             ]
        

main = gameApp Tick {
           model = init
          ,view = view
          ,update = update
          ,title = "Project 2"
          }
       
