
import qualified Data.Array as A
import System.Random
import Control.Monad

type Point = A.Array Int Int

minval = 0
maxval = 100000

{- Pareto dominance -}
x `domL` y = and $ zipWith (<=) (A.elems x) (A.elems y)
x `dom` y = x `domL` y && x /= y

genRandomPoint :: Int -> IO Point
genRandomPoint p = A.listArray (1,p) <$> forM [1..p] (pure $ randomRIO (minval,maxval))

addPointP :: [Point] -> Point -> Bool
addPointP pts npt = null [pti | pti <- pts, npt `dom` pti || pti `dom` npt]

genPoints :: Int -> Int -> IO [Point]
genPoints p n = genPoints' n []
    where genPoints' 0 pts = pure pts
          genPoints' n pts = do
                print n
                npt <- genRandomPoint p
                if addPointP pts npt
                   then genPoints' (n-1) (npt:pts)
                   else genPoints' n pts


exportNDSet p n file = genPoints p n >>= writeFile file . show . fmap A.elems
    
