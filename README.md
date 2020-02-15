# Random nondominated point generator
Generates a random set of nondominated points and exports it to a file. Use it with ghci.

```bash
$ sudo apt install haskell-platform
$ cabal install random
$ ghci NDPT-gen.hs
```

Examples:

```haskell

generateNDSet 3 1000 "p-3_n-1000.nds" -- 1000 random 3D points
```
