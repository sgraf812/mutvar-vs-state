import           Control.Monad.ST
import           Control.Monad.Trans.State.Strict
import           Criterion
import           Criterion.Main
import           Data.Primitive.MutVar

sumDirect :: (Eq a, Num a) => a -> a
sumDirect = impl 0
  where
    impl acc 0 = acc
    impl acc n = impl (n + acc) (n - 1)

sumState :: (Eq a, Num a) => a -> a
sumState = flip execState 0 . impl
  where
    impl 0 = get
    impl n = do
      modify' (+ n)
      impl (n - 1)

sumMutVar :: (Eq a, Num a) => a -> a
sumMutVar n = runST (newMutVar 0 >>= impl n)
  where
    impl 0 v = readMutVar v
    impl n v = do
      modifyMutVar' v (+ n)
      impl (n - 1) v

main :: IO ()
main = defaultMain
  [ bgroup "sum"
      [ benchSumDirect (1000000 :: Integer)
      , benchSumState (1000000 :: Integer)
      , benchSumMutVar (1000000 :: Integer)
      , benchSumDirect (1000000 :: Int)
      , benchSumState (1000000 :: Int)
      , benchSumMutVar (1000000 :: Int)
      ]
  ] where
      benchSumDirect n =
        bgroup "direct" [ bench (show n) (nf sumDirect n) ]
      benchSumState n =
        bgroup "state" [ bench (show n) (nf sumState n) ]
      benchSumMutVar n =
        bgroup "mutvar" [ bench (show n) (nf sumMutVar n) ]
