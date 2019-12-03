# Design Notes

## Inline/COW Shenanigans

It's impossible to say if, say, at arity 5 you're better off with a `struct`-based 5-way product or if you're better off with the COW pattern. You can certainly make reasonable guesses--at arity 5, generally you want COW--but there are always going to be exceptional situations like a five-way product of `UInt8`; conversely, even for a mere 2-way product you might think the `struct` is always the winner, but it's not--you could, say, wind up with a 2-way product of 4-way products of pairs of affine transformations, at which point you're almost-certainly better off with the COW pattern (although, even there, your concrete usage pattern will matter!).

Swift lacks a clean way to abstract the struct/COW distinction--that's a topic for elsewhere!--but we can do almost as good (and this shows up in the type signatures): we can create protocols for each product arity, make both our inline and COW implementations conform to the corresponding protocols, and then make our types generic in their choice of representation.

Doing it this way is making a trade-off: we get less-intuitive type signatures, but we avoid having 2-4+ "identical-but-for-representation-choice" implementations of many of our types.

Take the cartesian products, for example: for an n-way cartesian-product collection, both the *elements* and the *indices* are products of the source collections' *elements* and *indices*. Concretely, e.g., for a 4-way product collection like `CartesianProduct<A,B,C,D>` we *essentially* have:

- elements: 4-way product like `(A.Element, B.Element, C.Element, D.Element)`
- indices: 4-way product like `(A.Index, B.Index, C.Index, D.Index)`

...and thus we have two independent choices:

- should the elements use the inline or COW pattern?
- should the indices use the inline or COW pattern?

...neither of which is even possible to get correct, statically, in all cases.

A simple option is to have only a single product collection at each arity, make the safest guess for that arity, and move on. I rejected that--it leaves too performance much on the table. 

Another option is to implement all four possibilities: I could write `Chain4CollectionInlineElementInlineIndices`, and so on; really--and this is from experience!--with careful use of convenience typealiases I could write one of them out in full, then write the others by copy-and-paste, changing the name by find-and-replace, and then editing those typealiases. I can vouch that that works, but it leads to a lot of code bloat (or requires introducing GYB, which I don't want to do unless SPM gains support for that or something similar).

The option I went with is what I described above: the collection takes generic parameters not only for the constituent collections, but also for its choice of representation for the elements and indices. Here's how it winds up looking:

```swift
public struct Product4Collection<A,B,C,D,Position,Element>
where
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection,
  Position:AlgebraicProduct4,
  Position.A == A.Index,
  Position.B == B.Index,
  Position.C == C.Index,
  Position.D == D.Index,
  Element:AlgebraicProduct4,
  Element.A == A.Element,
  Element.B == B.Element,
  Element.C == C.Element,
  Element.D == D.Element {
    /* now the fun begins */
}
```

...which gets long to declare, but isn't hard to understand: a 4-way product collection has the 4 parameters you'd expect--the constituent collection types `A`, `B`, `C`, and `D`--as well as one more for the representation of the `Position` (explained shortly) and one more for the representation of the `Element`. 

I make this approach more-convenient to *use* by supplying (a) convenience typealiases that fill in the standard choice for `Position` and `Element` at each arity and also (b) providing free functions that *look* like type constructors but are easier-to-use than the actual constructors.

## `Collection`/`Index` Is Misdesigned

Working on the collections in this package has strengthened my opinion that the use of "half-open indices" is the wrong fundamental design. The right conceptual design would be something like this (at minimum):

- `Collection`s have `Position`s
- all `Position` values are subscriptable (no "one-past-the-end" `endIndex`)
- properties like `startIndex: Index` become `startPosition: Position?`, etc.
- replace `Range<Index>` with `ClosedRange<Position>` and `ClosedRange<Position>?` as-necessary
  
I say this because the half-open paradigm *composes* extremely poorly: so much of the code in e.g. the chain collections and product collections has to do with either (a) being very, very careful not to mistakenly use one of the constituent collections' end indices and (b) being very, very careful to handle the inherent asymmetry vis-a-vis `startIndex` and `endIndex`.

I'll say more about this elsewhere, but it's hard for me to see Swift's half-open paradigm as anything other than a *mistake*--it's a generalization of pointers and pointer arithmetic, but mistakenly interprets certain pointer particularities as part of an otherwise-useful abstraction.

In any case, essentially every single collection in this package uses that `Position` concept internally, and only promotes it to the `Index`-with-an-`endIndex` representation for use with the `Collection` API. 

## `Passthrough` Adoption?

In my [`HDLSIMDSupport` package](https://github.com/plx/HDXLSIMDSupport), I avoid a lot of boilerplate via my so-called `Passthrough` protocol:

```swift
protocol Passthrough {
  associatedtype PassthroughValue
  var passthroughValue: PassthroughValue { get set }
  init(passthroughValue: PassthroughValue)
}
```

...which is intended to correspond to "trivial, forwarding wrappers", like so:

```swift
public extension Passthrough /* : AlgebraicProduct2 */ where PassthroughValue:AlgebraicProduct2 {
  typealias A = PassthroughValue.A
  typealias B = PassthroughValue.B
  var a: A {
    get {
      return self.passthroughValue.a
    }
    set {
      self.passthroughValue.a = newValue
    }
  }
  
  // you get the idea
}
```

...which then lets *write* our forwarding logic once-per-protocol.

This won't work quite so simply, here--we'd *also* need something like this:

```swift
public extension Passthrough /* : AlgebraicProduct2 */ where PassthroughValue:AlgebraicProduct2 & AnyObject {
  typealias A = PassthroughValue.A
  typealias B = PassthroughValue.B
  var a: A {
    get {
      return self.passthroughValue.a
    }
    set {
      if !isKnownUniquelyReferenced(&self.passthroughValue) {
        self.passthroughValue = self.passthroughValue.with(
          a: newValue
        )
      } else {
        self.passthroughValue.a = newValue
      }
    }
  }
}
```

...which wasn't necessary for the SIMD types b/c the wrapped types were exclusively structs.

This pattern would thus require twice as much code--"twice per protocol" instead of "once per protocol"--but might still go a long way to reduce the package's boilerplate.

I hesitate to go that route, however, b/c that SIMD package suffers from excessive compile times--30-40 minutes, or more!--and it's possible `Passthrough` is to blame. If I can rule that out, I'll consider it for here, but for now I'm just noting the possibility *and* noting why I didn't use it.

If I *do* go that route, however, I'll first need to extract `Passthrough` into its own package, which is its own potential can of worms--I think cross-module inlining will allow for reasonable efficiency, but I might have to start using the "forbidden" attributes like `@_transparent` and `@inline(__always)`.
