# Design Notes

Implementing-and-using this package turned out to be a bit of a mad-science experiment: on the one hand, I find the functionality, itself, extremely-useful in many cases; on the other hand, the implementation and use of this package exposed a *lot* of awkward spots, subtle gotchas, and other unfortunate aspects of Swift-the-language and Swift-the-ecosystem (e.g. standard library).

For the most part I'm satisfied with where it's at--at least as a prototype--but to get it to this point I had to overcome a lot of seemingly-unusual issues...which required inventing a lot of techniques I haven't (yet) seen used elsewhere (probably not unique, just...I hadn't seen before).

In this document I describe some of those techniques and issues--if you find something baffling in the code, hopefully you'll find some insight here.

## Pseudo-Types and Pseudo-Constructors

For reasons explained below, (a) the `ProductN` types come in two *flavors* ("inline" and "COW") and (b) many of the collections take a few "extra", non-intuitive type parameters--you might expect `Product4Collection<A,B,C,D>`, but it's actually `Product4Collection<A,B,C,D,Element,Position>` (and would *ideally* have one more "bonus" parameter).

What I call pseudo-types are just (public) typealiases, but with more-favorable names than the types they reference:

```swift
/// Safe default choice for the arity-2 product.
public typealias Product2<A,B> = InlineProduct2<A,B>

/* snip */

/// Safe default choice for the arity-9 product.
public typealias Product9<A,B,C,D,E,F,G,H,I> = COWProduct9<A,B,C,D,E,F,G,H,I>
```

The `ProductN` typealiases are thus a user-friendly facade--they're what public APIs typically use, they're what you should use by default, but when you need more control you can always "drop down" to the underlying names.

What I call pseudo-constructors are free functions that serve a similar purpose: they have nice names, they sometimes hide some of the type parameters, and they exploit overloading for improved readability:

```swift
/// Pseudo-constructor for the arity-2 product.
func Product<A,B>(_ a: A, _ b: B) -> Product2<A,B> {
  return Product2<A,B>(a,b)
}

/* ... */

/// Pseudo-constructor for the arity-9 product.
func Product<A,B,C,D,E,F,G,H,I>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) -> Product9<A,B,C,D,E,F,G,H,I> {
  return Product9<A,B,C,D,E,F,G,H,I>(a, b, c, d, e, f, g, h, i)
}
```

...which pattern continues on into the collections, where it's more helpful

```swift
// ugly , but useful to define:
public typealias
  CartesianProduct2<
    A:Collection,
    B:Collection>
  =
  Product2Collection<
    A,B,
    StandardPositionRepresentation2<A,B>,
    StandardElementRepresentation2<A,B>>

/// Pseudo-constructor for the arity-2 cartesian product
func CartesianProduct<A:Collection,B:Collection>(_ a: A, _ b: B) -> CartesianProduct2<A,B> {
  return CartesianProduct2<A,B>(a, b)
}
```

The benefit of this technique is that at use sites, the functionality has the *appearance* of being (a) simpler and (b) more-uniform--there's not *really* an overloaded `CartesianProduct` type, but the name and usage lets us pretend there is. The downside, of course, is initial confusion at the long chains of typealiases--hopefully this section makes it easier to follow!

I intend to revisit this a bit once the `some` keyword gains support for writing *local* `where` clauses--right now you *can* write `some Collection` as the return type, but it loses too much information to be practical.

## Inline, COW, Generics

I intend to write a detailed article on this topic, so will only sketch the issue here. 

Briefly, then, idiomatic Swift datatypes have "value semantics", for which there are two common approaches: (a) implement the type as a simple `struct` or (b) implement the type as a `struct` wrapping a `class` and using the copy-on-write pattern upon mutation; since both involve a `struct` I will refer to (a) as the "inline" approach and (b) as the "COW" approach.

As a very loose approximation--and borrowing accounting terminology--you can think of the performance characteristics like so: "inline" has zero fixed costs and unbounded, monotonically-increasing variable costs; "COW" has nontrivial fixed costs but nearly-zero variable costs. Where this becomes tricky to pin down is that variability: "inline" gets more-and-more expensive due to increases in size, it gets more-and-more expensive due to increases in ARC traffic, but the significance of those increases will be highly-contingent upon the concrete usage pattern.

Going deeper into this topic will have to wait for the upcoming article, so let's move on to the significance vis-a-vis this library.

For the `ProductN` family I include parallel implementations: there's both (a) an "InlineProductN" at each arity and also (b) a "COWProductN" at each arity; they both obtain the bulk of their APIs from a corresponding arity-specific protocol, and are thus completely-interchangeable. 

We need both at each arity because even though we *can* provide reasonable *defaults*--"inline" by default at arity 2, "COW" by default at arity 9, etc.--those *defaults* will wind up exhibiting poor-to-pathological performance in many scenarios.

Many 9-way products of primitives would be better off inline--COW overhead is expensive if you're got a 9-way product of, say, 8, 16, or even 32-bit integer types. In a similar vein you might think that you can always get away with "inline" at arity 2, but this assumption fails even under realistic levels of composition: an `(Int,Int)` product *should* be inline, but what about a product 2-way product of, say, `Chain3Collection<[String],Set<String>,Fixed8Collection<String>>`?
  
Note that I'm very much speaking from experience, here. I initially just implemented each product once--using the "reasonable default" for each arity--but then when I started *using* that iteration, I realized that I was paying too much COW overhead in many large-arity cases and, conversely, was getting pathological slowdowns from low-arity products of low-arity products of low-arity products of ...you get the idea.

Thus, for now, I provide the parallel implementations, abstract their commonalities into the corresponding protocols, provide pseudo-types for the reasonable defaults, and then use pseudo-constructors to streamline this setup as much as possible. This is, incidentally, where the extra type parameters come from in the `Collection` types: rather than, say, have 4 nearly-identical implementations of `ProductNCollection`, I, instead, have one implementation that is generic in both its constituents--`A`, `B`, etc.--and in the concrete `ProductN` type used for its `Index` and its `Element`.

What makes the "inline"/"COW" split so insidious is that Swift's generics require a generic type to work with every compatible set of type parameters. I mean, sure, that's arguably the definition of *generic*, but these issues could be substantially mitigated by the following:

- provide a way to constrain generic parameters by ARC participation and size: `struct Foo<T> where size(of: T) <= 32` or `struct Bar<A,B,C> where ARCParticipation(A,B,C) <= 4`
- provide a way to provide multiple equivalent implementations that get used transparently--basically promoting an ehanced form of pseudo-constructor to a language-level feature
- provide a way to define a "closed protocol"--call it a `datum`, for now--for which the following hold:
  - you can specify the core properties and methods of a `datum` 
  - you can define extensions on that `datum` (for defaults & common utilities)
  - you can get reasonable auto-synthesized "inline" and "COW" implementations
  - it's *closed*: only the auto-synthesized types can conform, and that synthesis can only occur within the package defining the type
  - it's a type constraint: generic code can still *use* the `datum` as a type bound (perhaps with guaranteed exploitation of its *closed* status to guarantee performance equivalent to providing concrete overloads for each of those derived types--"de-genericizing" code using such type constraints)

All of those are "big asks", all of them are not deeply considered, but they are attempts to address a deeply-felt problem...a problem that arises once more in the next note, albeit under another guise.

## Generics, Collections, & Performance

Swift collections come in three primary flavors: `Collection`, `BidirectionalCollection`, and `RandomAccessCollection`; the API is *almost* the same between them, but they differ in their navigation:

- `Collection` navigation is forward-only and may be `O(n)`
- `BidirectionalCollection` supports backwards navigation and may be `O(n)`  
- `RandomAccessCollection` supports arbitrary navigation and must be `O(1)`

...with performance of `count` tracking the performance of navigation.

Swift generics requires generic types to provide a single, one-size-fits-all implementation, and this requirement interacts very awkwardly indeed with the three flavors defined above. I'll illustrate it with `Chain4Collection`:

```swift
extension Chain4Collection {
  
  // naive implementation
  var naiveCount: Int {
    get {
      self.a.count + self.b.count + self.c.count + self.d.count
    }
  }
}
```

This naive version has a trivial implementation--forwarding to the underlying collections in the obvious way--but necessarily inherits their performance: any combination of `a`, `b`, `c`, or `d` can have `O(n)`-tier count!

Although we make an O(n) `count` into an O(1) `count`, we *can* cache the value so we only have to calculate it when strictly necessary:

```swift
extension Chain4Collection {
  
  // store our cache here:
  internal var _count: Int? = nil
  
  // use the cache when we can, recalculate when we must:
  var naiveCachingCount: Int {
    get {
      // returns `_count` when already non-`nil`;
      // when `nil` calculates value, stores it in `_count`, then returns it
      // 
      // correctness requires resetting `_count` after mutating `a`, `b`, etc.
      return self._count.obtainAssuredValue(
        fallingBackUpon: self.naiveCount
      )
    }
  }
  
}
```

That caching approach *works*, but leaves a lot of low-hanging fruit for our collection combinators: we *must* reset `_count` whenever we mutate `a`, for example, but if all we've done is mutate `a` why *should* we re-`count` `b`, `c`, or `d`? Better still--in theory--would be to cache the per-collection `count`s: 

```swift
extension Chain4Collection {

  internal var _aCount: Int? = nil
  internal var _bCount: Int? = nil
  internal var _cCount: Int? = nil
  internal var _dCount: Int? = nil
  
  // i'll just write out `a`, but same boilerplate for `b`, `c`, and `d`:
  var aCount: Int {
    get {
      return self._aCount.obtainAssuredValue(
        fallingBackUpon: self.a.count
      )
    }
  }
  
  // you could arguably drop this in favor of always recalculating the sum of 
  // the constituent counts, but there's good reasons to keep this cache:
  // if we wanted to, we could do "fixups" on the cached value when we mutate
  // the constituents--subtract old count, add new count...
  internal var _count: Int? = nil
  var count: Int {
    get {
      return self._count.obtainAssuredValue(
        fallingBackUpon: self.aCount + self.bCount + self.cCount + self.dCount
      )
    }
  }
  
}
```

The above works, and property wrappers make it a lot less painful in practice: the collections all store their consituents in a property wrapper that caches the most-important properties, thereby helping us smooth over some of the worst-case performance scenarios.

I'm using `count`, here, for ease of illustration, but the need for caching is a bit more pervasive: within these collection combinators it's frequently-necessary to access the final *subscriptable* index--not `endIndex`, but the subscriptable index just before it (if there indeed is one). This, too, can be an `O(n)` operation in the worst cases, is accessed much more often than `count`, and thus I take care to cache it, too.

With that out of the way, all of the above is actually suboptimal for two *overlapping* reasons: (a) introducing this caching forces into only having COW-backed collection-combinators, but (b) for `RandomAccessCollection` we don't really *need* all that caching, and could often benefit from parallel, non-COW implementations. 

To elaborate on (a), caching as per the above intrinsically introduces mutation into what would otherwise be non-mutating, read-only getters: we *can* get away with this via "COW", but not so much in a hypothetical "inline" equivalent. Moreover, even if we *could* use the "inline" approach, all that caching would balloon the size of the `struct` well past the point of practicality--N+1 cached counts, N cached final subscriptable indices, and even some other cached properties not mentioned here.

That being said, (b) remains true: many of the random-access collections I use most often are essentially-trivial--`Range<Int>`, for one! In such cases, it seems silly to pay both the COW overhead *and* the caching overhead, especially when such collections are often short-lived. This isn't entirely-unaddressable, but it's not easily-addressable: I can make the "inline"-vs-"COW" choice user-controllable via "extra" type parameters, but that trick won't work for backing storage due to my use of property wrappers.
  
So, for now, all I will do is note this unfortunate interaction between providing a generic implementation, smoothing over worst-case performance, and *not* avoiding unnecessary overhead in the best-case scenarios.
  
## `Collection`/`Index` Is Misdesigned

I've always found Swift's use of half-open indexing questionable, but my experiences writing this package have convinced me it's the wrong design: the half-open paradigm works fine in simple scenarios, but composes *extremely-poorly*--and in extremely error-prone ways--in essentially any collection-combinator scenario.

As an alternative, better-composing design I use what I term a `Position`. `Position`s resemble indices, but with tweaked semantics:

- a `Position` is *always* subscriptable (thus e.g. an empty collection has no valid `Position`s, instead of the `startIndex == endIndex` footgun) 
- when necessary, one works with `ClosedRange<Position>`--or optionals thereof--instead of `Range<Index>`
  
One can promote such `Position`s to a conventional `Index` in a trivial, generic way--all you need is an enumeration like this:

```swift
enum PositionIndex<Position:Comparable> {
  case position(Position)
  case end
}
```

...with a bit of boilerplate; the bold can even just go with `Optional<Position>`, I think, although you might need a struct wrapper around that to make sure `<` puts `nil` *last*. For various reasons it's best to hide that enum inside a `struct`--it's otherwise hard to enforce certain invariants on the `Position`--but that, too, can be done once-and-forever in a fairly trivial way.
  
That's enough about what a `Position` *is*--why do I say it composes better?

I'll use `Chain4Collection`, again, as it is "big enough" to illustrate the point but not excessively-large. Here's what an implementation based directly on `Index` might look like:

```swift
enum Chain4CollectionIndex<A:Comparable,B:Comparable,C:Comparable,D:Comparable> {
  case a(A)
  case b(B)
  case c(C)
  case d(D) // could use d(self.d.endIndex) and drop `end`, too
  case end 
}

extension Chain4Collection {
  
  // so far so good
  typealias Index = Chain4CollectionIndex<A.Index,B.Index,C.Index,D.Index>
  
  // first hint of trouble: it's not `.a(self.a.startIndex)`, b/c that might
  // actually be `.a(self.a.endIndex)` "in disguise"; what we need to do is 
  // walk forward until we find our first non-empty collection, like so:
  var startIndex: Index {
    get {
      // a bit confusing, but this is the *tightest* I've managed to get it:
      guard self.a.isEmpty else {
        return .a(self.a.startIndex)
      }
      guard self.b.isEmpty else {
        return .b(self.b.startIndex)
      }
      guard self.c.isEmpty else {
        return .c(self.c.startIndex)
      }
      guard self.d.isEmpty else {
        return .d(self.d.startIndex)
      }
      return .end
      // if we didn't have a `.end` case, we *could* unconditionally-return
      // `.d(self.d.startIndex)` after getting past .c, but see below
    }
  }
  
  // end index is boring, so we skip it...
  // this isn't boring, though:
  subscript(index: Index) -> Element {
    get {
      switch index {
      case .a(let aIndex):
        precondition(aIndex != self.a.endIndex) // <- be bad to get this wrong
        return self.a[aIndex]
      case .b(let bIndex):
        precondition(bIndex != self.b.endIndex) // <- be bad to get this wrong
        return self.b[bIndex]
      case .c(let cIndex):
        precondition(cIndex != self.c.endIndex) // <- be bad to get this wrong
        return self.c[cIndex]
      case .d(let dIndex):
        precondition(dIndex != self.d.endIndex) // <- be bad to get this wrong
        return self.d[dIndex]
      case .end:
        preconditionFailure("Subscripted the .end index!")
      // ^ this is why the extra `.end` case is nice to have: without it, we
      // have to handle the `case .d(_)` branches differently, but with it
      // we can generally handle everything uniformly
      }
    }
  }
  
  // here's another not-so-easy one: `index(after:)`!
  // the issue is if e.g. you're in `a` and hit the end index, you can't *just*
  // go to `.b(self.b.startIndex)`, b/c `self.b` could be empty; same for `.c`
  // and `.d`, too...
  func index(after index: Index) -> Index {
    // as before it's super-clunky, but it's as tight as I can make it while
    // working with the `Index` API on its own terms; you may think I'm being
    // unfair, here, but all I'm really doing is putting the necessary logic 
    // front-and-center:
    switch index {
    case .a(let aIndex):
      precondition(aIndex != self.a.endIndex) // <- be bad to get this wrong
      let nextAIndex = self.a.index(after: aIndex)
      guard nextAIndex == self.a.endIndex else {
        return .a(nextAIndex)
      }
      guard self.b.isEmpty else {
        return .b(self.b.startIndex)
      }
      guard self.c.isEmpty else {
        return .c(self.c.startIndex)
      }
      guard self.d.isEmpty else {
        return .d(self.d.startIndex)
      }
      return .end
    case .b(let bIndex):
      precondition(bIndex != self.b.endIndex) // <- be bad to get this wrong
      let nextBIndex = self.b.index(after: bIndex)
      guard nextBIndex == self.b.endIndex else {
        return .b(nextBIndex)  
      }
      guard self.c.isEmpty else {
        return .c(self.c.startIndex)
      }
      guard self.d.isEmpty else {
        return .d(self.d.startIndex)
      }
      return .end
    case .c(let cIndex):
      precondition(cIndex != self.c.endIndex) // <- be bad to get this wrong
      let nextCIndex = self.c.index(after: cIndex)
      guard nextCIndex == self.c.endIndex else {
        return .c(nextCIndex)  
      }
      guard self.d.isEmpty else {
        return .d(self.d.startIndex)
      }
      return .end
    case .d(let dIndex):
      precondition(dIndex != self.d.endIndex) // <- be bad to get this wrong
      let nextDIndex = self.d.index(after: dIndex)
      guard nextDIndex == self.d.endIndex else {
        return .d(nextDIndex)  
      }
      return .end
    }
  }
  
}
```

...and I hope you get the idea: collections can be empty, empty collections have identical start-and-end indices; for safety you *must* be careful to check for the `endIndex`--here and everywhere else you manipulate indices--but you get absolutely no out-of-the-box help from the compiler.

If we use a `Position`-based approach, however, everything starts composing far more smoothly:

```swift
// need these for the below; can't *use* `firstPosition`, etc., here, b/c that
// would conflict with the same-name properties used downstream
extension Collection {
  var firstSubscriptableIndex: Index? {
    return self.isEmpty ? nil : self.startIndex
  }
  
  var finalSubscriptableIndex: Index? {
    // this can be O(n) and thus in practice we take care to cache it...
    return self.isEmpty ? nil : self.index(self.startIndex, offsetBy: self.count - 1)
  }  
  
  func subscriptableIndex(after index: Index) -> Index? {
    guard index < self.endIndex else {
      return nil
    }
    let nextIndex = self.index(after: index)
    return nextIndex == self.endIndex ? nil : nextIndex
  }
}

extension Chain4Collection {
  
  // keep this internal to enforce the "subscriptable indices only" rule
  internal typealias Position = Sum4<A.Index,B.Index,C.Index,D.Index>
  
  var firstPosition: Position? {
    get {
      return Position.firstNonNil(
        self.a.firstSubscriptableIndex,
        self.b.firstSubscriptableIndex,
        self.c.firstSubscriptableIndex,
        self.d.firstSubscriptableIndex
      )
    }
  }
  
  var finalPosition: Position? {
    get {
      return Position.finalNonNil(
        self.a.finalSubscriptableIndex,
        self.b.finalSubscriptableIndex,
        self.c.finalSubscriptableIndex,
        self.d.finalSubscriptableIndex
      )
    }
  }
  
  subscript(position: Position) -> Element {
    get {
      // no risk of `endIndex` subscription, and--by assumption, at least--can't
      // have the constituent `endIndex` show up in any of the below:
      switch position {
      case .a(let aIndex):
        return self.a[aIndex]
      case .b(let bIndex):
        return self.b[bIndex]
      case .c(let cIndex):
        return self.c[cIndex]
      case .d(let dIndex):
        return self.d[dIndex]
      }
    }
  }
  
  func position(after position: Position) -> Position? {
    switch position {
    case .a(let aIndex):
      return Position.firstNonNil(
        self.a.subscriptableIndex(after: aIndex),
        self.b.firstSubscriptableIndex,
        self.c.firstSubscriptableIndex,
        self.d.firstSubscriptableIndex
      )
    case .b(let bIndex):
      return Position.firstNonNil(
        nil,
        self.b.subscriptableIndex(after: bIndex),
        self.c.firstSubscriptableIndex,
        self.d.firstSubscriptableIndex
      )
    case .c(let cIndex):
      return Position.firstNonNil(
        nil,
        nil,
        self.c.subscriptableIndex(after: cIndex),
        self.d.firstSubscriptableIndex
      )
    case .d(let dIndex):
      return Position.firstNonNil(
        nil,
        nil,
        nil,
        self.d.subscriptableIndex(after: dIndex)
      )
    }
  }
  
}
```

Don't get me wrong--it's still *boilerplate*--but at least to my eyes it's *vastly* simpler-and-cleaner boilerplate. This cleaner composition extends even more into cases dealing with doing `index(_:offsetBy:)`, or `distance(from:to:)`, and so on and so forth--you can't escape the boilerplate, but you *can* make it easier on the eyes *and* get the compiler to tag along and help verify you didn't miss a check against `endIndex`.

To wind this down, then, essentially every single collection in this package is implemented in terms of `Position`, not `Index`, and then uses a (wrapper around) something equivalent-to `PositionIndex` to fit itself into the index-based API.

Before moving on, however, I think the best summary of my view is that (a) the half-open paradigm is slightly simpler-and-cleaner for the simplest cases but (b) the pervasive awkwardness, fiddliness, and error-prone-ness vis-a-vis composition reveals the half-open paradigm to be the wrong abstraction overall.

## Collections, Generics, Overrides

Here's a minor issue: in many cases I provide overrides of methods like `contains()` even though they won't be called in many generic contexts:

```swift
extension Product9Collection where /* Elements are equatable */ {
  
  func contains(_ element: Element) -> Bool {
    guard
      self.a.contains(element.a),
      self.b.contains(element.b),
      self.c.contains(element.c),
      self.d.contains(element.d),
      self.e.contains(element.e),
      self.f.contains(element.f),
      self.g.contains(element.g),
      self.h.contains(element.h),
      self.i.contains(element.i) else {
        return false
      }
      return true
  }
  
}
```

I do this simply because the benefit when such methods *do* get called is enough to justify their inclusion--do you really want to fall back on a linear search through a high-arity cartesian product when you can avoid it? 

I mention this because I believe Swift would, in general, benefit from growing the capability for protocols to define *conditional* extension points:

```swift
// Hypothetical declaration: this API is only available when the condition is
// met, but--when available--types can supply their own implementations.
overrideable extension Collection where Element:Equatable {
  func contains(_ element: Element) -> Bool 
}
```

There'd be details to work out about where such things could be declared, how they'd interact across modules, etc.--and for backwards compatibility I could anticipate a "default must be supplied" requirement--but this capability would pick up what's *currently* a lot of low-hanging fruit.
