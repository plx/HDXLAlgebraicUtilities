# Future Directions

This document contains miscellaneous *future directions* for this project: they're things I might do--and things for which I would certainly welcome contributions!

## Change to GYB or `Passthrough`

This package contains a ton of code, much of it self-evident boilerplate. Since it's boilerplate that's actually written-out, however, it's hard to experiment with design tweaks: you'd want things to have consistent implementations, but nothing other than inertia is keeping the per-arity implementations mutually-consistent.

The code seems highly-amenable to code generation, and it might thus make sense to "port" this code to, say, GYB. If done successfully, that'd let me (a) generate arities *at will* and (b) experiment, rapidly, with alternate implementation choices, method annotations, and so on.

Alternatively I could use the `Passthrough` protocol I use in my SIMD library: this approach has the advantage of being a pure-swift boilerplate-reduction technique, with the disadvantage of seemingly being less-useful here rather than there--it would benefit form extension and rethinking if used here.

These techniques could, of course, be combined.

## Missing Tools

Some useful collections are missing, but could be added (or restored).

There *used* to be a `FixedOptionalNCollection` that was a "fixed maximum size" collection that ignored any `nil` components. In other words:

- `FixedCollection(1,2,3)`: 3-element collection containing 1, 2, and 3
- `FixedOptionalCollection(1,nil,3)`: 2-element collection containin 1 and 3

I removed it, for now, b/c I hadn't yet converted it to the parameterizable-storage design I used for the fixed-size collections. 

Another possibly-useful collection would be either of these:

- `SumNCollection`: given N collection types with a common `Element`,  a bit like `AnyCollection`, but sans type-erasure
- `SumSumNCollection`: like the previous, but allowing heterogeneous `Element` types

There's also room for including more "overrides" of the standard extensions on `Collection`; I could see adding custom mirrors/reflection here and there, or adding conditional lossless-string-convertible implementations where appropriate, and so on.

Finally there's *arguably* a case for adding an optional-flavored variant of products, e.g. like this:

- `SumN`: exactly one value, of N possible types
- `ProductN`: N values, one from each type
- `MaskN`: any combination of `nil` and non-`nil` values from N types 

`MaskN` is a bit redundant vis-a-vis `ProductN`, but arguably is a distinct thing that just happens to be *implementable* atop `ProductN`. It's niche-enough I haven't yet used it, though, so it remains TBD.

I could do specialized, `RandomAccessCollection`-flavored variants of the collection combinators. The motivation for this I discuss in the design notes, it's not urgent, but it's a thing.

Also, it'd be slick-looking to introduce operators for constructing products and sums. I haven't done so b/c (a) I don't think it's possible to do type-level operators in Swift and (b) doing it for values seems like it'll devolve into compiler-confusing ambiguity without, say, explicitly-annotating the types anyways--and at that point, why bother?

## Fix Indices

One major mistake in this code is that most of my index types are generic, but need collections as their type parameters, not indices:

```swift
// I have this:
struct Chain2CollectionIndex<A:Collection,B:Collection> {
  //
}

// I should have this:
struct Chain2CollectionIndex<A:Comparable,B:Comparable> {
  
}
```

It's not a hard change to make, just tedious and of low urgency. The resulting *problem* is a missed opportunity:

```swift
extension Chain2Collection {
  
  // this should work, but doesn't:
  typealias Indices = Chain2Collection<A.Indices,B.Indices>
  
}
```

That doesn't work because (a) the relevant type constraints require that `Indices.Index == Self.Index` but (b) as currently-implemented, we have `Indices.Index == Chain2CollectionIndex<A.Indices,B.Indices>` whereas the base `Index == Chain2CollectionIndex<A,B>`. You may object that that very same type constraint *should* mean that this *should* work--I certainly did when I discovered this issue!--but, last I checked, the compiler isn't able to figure out that they're actually the same index.

Until I thus "fix" the index definitions, then, I can't use combinators to implement their own `Indices`--very much a missed opportunity for elegance.

## Code Deduplication

Similarly to the above--and arguably to be addressed at the same time--I have distinct, hand-rolled `Position`-to-`Index` adaptors for each collection. This is pointless and they should all get consolidated; there's a reason I didn't do that--I worried about the public API containing adaptors that couldn't be used *outside* the package--but at this point I would strongly favor consolidation.

## Refactoring

Aesthetically, I like the idea of refactoring this package like so:

- one sub-package per arity
- an "omnibus", all-in-one/convenience library bundling the above

My motivation for doing so would be to make it possible to reduce binary bloat. For *app development* this is less of a concern, but would become more relevant when, say, trying to use some of this functionality in binary frameworks.

Actually making the change would be "easy"--the code should already cleave nicely into per-arity mdules, and just needs physical reorganization; the holdup, here, is mostly about deciding if it's actually worth doing.

## Combine & SwiftUI

At present, I include some SwiftUI-related types: `SumNView`, `VectorArithmetic` conformances on the algebraic types, that kind of thing. Their inclusion in the package is obviously an impediment to making this "cross platform"--I'm fine with that for my own needs, but can understand why others wouldn't be. I'm thus open to extracting the SwiftUI-dependent code into a separate product--probably within this package, unless that would still prevent this from being cross-platform--it's just not something I've gotten around to, yet.

Similarly, a lot of this functionality should play nicely with `Combine`--it seems like it should, I plan to investigate that, and just haven't yet gotten around to it. That functionality I will, however, definitely include within its own product--or its own package, if need be--rather than bake it in as I did when experimenting with SwiftUI.