# HDXLAlgebraicUtilities

This package provides (a) algebraic sums, (b) algebraic products, and (c) an assortment of collections related to (a) and (b). These are provided in arities from 2 through 9, inclusive.

I've included separate `Motivation.md`, `DesignNotes.md`, and `FutureDirections.md` files in addition to this `Readme.md`--go there for more detail.

## Usage Examples

This package provides too *large* of an API to illustrate in full, but here are some highlights. 

Algebraic sums are named `Sum2`, `Sum3`, etc., and can be used whenever you want a fully-featured enumeration but don't want to define a full type for one use case. Here's one possible example:

```swift
import SwiftUI
import HDXLCommonUtilities

protocol DataView : View {
  associatedtype Data
  init(data: Data)
}

/// General-purpose, data-driven "this-or-that" view.
struct Sum2DataView<A:DataView,B:DataView> : DataView {
  
  typealias Data = Sum2<A.Data,B.Data>
  
  private var data: Data 
  
  init(data: Data) {
    self.data = data
  }
  
  // would be nice not to need type-erasure here.
  // Perhaps a one-element HStack, VStack, or ZStack would be preferable?
  var body: some View {
    switch self.data {
    case .a(let aData):
      return AnyView(A(data: aData))
    case .b(let bData):
      return AnyView(B(data: bData))
    }
  }
  
}
```

The `SumN` types, in other words, are essentially the "most-general enums" at each `N`: suitable for use when you need an n-way enum, but don't need anything more specific; conditional conformances are supplied for the common protocols, and you can obviously write your own to suit your own needs.

The `ProductN` family is similar: each `ProductN` is a fully-general N-element struct, and--as such--can be used wherever you might otherwise use a tuple. The advantage of the `ProductN` family over tuples is simply that the `ProductN` types are nominal types and, thus, can conform to protocols:

```swift
let xs: [Int]
let ys: [Int]

// `xys` will be `Equatable`, but *not* its (Int,Int) elements 
let xys = zip(xs,ys)

// `algebraicXYs` and its elements will be `Equatable`
let algebraicXYs = ProductZipCollection(xs,ys)
```

If nothing else, collections that vend `ProductN` instead of tuples will compose better; this seems likely to grow more and more important as e.g. `SwiftUI` and `Combine` push idiomatic Swift into ever-more functional-and-compositional directions. 

Here's some collection-level highlights:

```swift
let xs: [Int] = [1 ,  2,  3]
let ys: [Int] = [11, 12, 13]
let zs: [Int] = [21, 22, 23]

// chain collection will be contents-of `xs`, then `ys`, then `zs`:
let doubledChain = ChainCollection(xs,ys,zs).map() { 2 * $0 }
// contents will be [2,4,6,22,24,26,42,44,46];

// cartesian product will be all `(x,y,z)` from `xs`, `ys`, `zs`
let stringifiedTriples = CartesianProduct(xs,ys,zs).map() {
  "(\($0.a), \($0.b), \($0.c))"
}
// contents will be: [
// "(1,11,21)","(1,11,22)","(1,11,23)",
// "(1,12,21)","(1,12,22)","(1,12,23)",
// "(1,13,21)","(1,13,22)","(1,13,23)",
// "(2,11,21)","(2,11,22)","(2,11,23)",
// "(2,12,21)","(2,12,22)","(2,12,23)",
// "(2,13,21)","(2,13,22)","(2,13,23)",
// "(3,11,21)","(3,11,22)","(3,11,23)",
// "(3,12,21)","(3,12,22)","(3,12,23)",
// "(3,13,21)","(3,13,22)","(3,13,23)"
// ]

// all side-by-side elements (with overlap)
let adjacentXYZs = AdjacentPairs(ChainCollection(xs,ys,zs))
// contents: (1,2), (2,3), (3,11), (11,12), (12,13), ... 
// except as `Product2`, not tuples
```

## Project Status

I consider this package a successful *experiment*: the code works, the functionality is valuable, and I use it all the time *when prototyping*. 

Using it in production is a bit trickier, because you pay a price for the convenience--particularly for the collections: in `Debug` the collections are about an order of magnitude slower than the equivalent, manual iteration; in `Release` they're still, generally, around 2-3x slower than manual equivalents. Whether or not that *matters* depends a lot on your specific use case. For example, I successfully used this algebraic functionality in a performance-sensitive, large-scale collection view layout, but in that case the collection-combinators were only used *off of* the hottest code path. 

The other potential issue is code bloat: the package is about 35mb when compiled, give or take. Even if "you only pay for what you use", the interconnectedness of the code means anything you formally invite will show up with its five closest friends. It'll take more time and actual usage to see how much of an issue this is--or isn't--but it's worth knowing about in advance.
