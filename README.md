# mutvar-vs-state

A small experiment, proving that [`MutVar`s](https://hackage.haskell.org/package/primitive-0.6.2.0/docs/Data-Primitive-MutVar.html) are actually a tad slower than computations utilising (strict!) `State`.

There are two benchmark groups (`Integer` vs. `Int`), each with 3 variations (direct tail-recursive, strict `State`, `MutVar`), modeling `\n -> sum [1..n]`.

Example run:

```
benchmarking sum/direct/1000000                                 
time                 21.20 ms   (20.71 ms .. 21.60 ms)          
                     0.997 R²   (0.992 R² .. 0.999 R²)          
mean                 21.63 ms   (21.37 ms .. 22.26 ms)          
std dev              923.0 us   (399.3 us .. 1.612 ms)          
variance introduced by outliers: 13% (moderately inflated)      
                                                                
benchmarking sum/state/1000000                                  
time                 21.43 ms   (20.96 ms .. 22.13 ms)          
                     0.995 R²   (0.989 R² .. 0.999 R²)          
mean                 21.29 ms   (21.09 ms .. 21.70 ms)          
std dev              674.9 us   (402.5 us .. 1.089 ms)          
                                                                
benchmarking sum/mutvar/1000000                                 
time                 22.58 ms   (22.30 ms .. 22.92 ms)          
                     0.999 R²   (0.998 R² .. 1.000 R²)          
mean                 22.80 ms   (22.60 ms .. 23.14 ms)          
std dev              578.8 us   (329.1 us .. 975.9 us)          
                                                                
benchmarking sum/direct/1000000                                 
time                 599.6 us   (596.5 us .. 604.3 us)          
                     0.998 R²   (0.994 R² .. 1.000 R²)          
mean                 608.2 us   (601.3 us .. 625.6 us)          
std dev              36.89 us   (9.630 us .. 69.30 us)          
variance introduced by outliers: 53% (severely inflated)        
                                                                
benchmarking sum/state/1000000                                  
time                 607.5 us   (600.3 us .. 616.5 us)          
                     0.998 R²   (0.996 R² .. 1.000 R²)          
mean                 604.7 us   (601.1 us .. 612.6 us)          
std dev              16.95 us   (10.16 us .. 28.63 us)          
variance introduced by outliers: 19% (moderately inflated)      
                                                                
benchmarking sum/mutvar/1000000                                 
time                 4.971 ms   (4.844 ms .. 5.171 ms)          
                     0.992 R²   (0.981 R² .. 0.999 R²)          
mean                 5.098 ms   (5.007 ms .. 5.232 ms)          
std dev              327.7 us   (218.3 us .. 464.8 us)          
variance introduced by outliers: 40% (moderately inflated)
```