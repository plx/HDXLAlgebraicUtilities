# Algebraic Programming: Motivation

Here's why this package exists.

## Primary Motivation

My initial motivation was very practical: I wanted a type-safe API for building aggregate UI components (table views, collection views, and some fully-custom concepts). In isolation, the UI-handling components of such systems don't *need* algebraic types, per se, and in extremely-simplified form can be *sketched* like so:

```swift
/// Protocol adopted by per-cell content data.
protocol ContentElement : Equatable, Hashable {
}

/// Protocol handling content presentation.
protocol ContentElementPresenter {
  associatedtype Element: ContentElement
  associatedtype Presentation: TableViewCellPresentation

  /// Set ourselves up for subsequent dequeuement.
  func register(with tableView: UITableView)
  
  /// Dequeue the appropriate cell type from the table view.
  func dequeuePresentation(
    for element: Element,
    at indexPath: IndexPath,     
    from tableView: UITableView) -> Presentation
    
  /// (Re)populate `cell` with the content from `element`,
  /// providing index path & table view for reference.
  func populate(
    presentation: Presentation,
    at indexPath: IndexPath, 
    in tableView: UITableView,
    for element: Element)  

}

/// The need for this type will be apparently shortly.
protocol TableViewCellPresentation {
  var underlyingTableViewCell: UITableViewCell { get }
}
```

...which, still in simplified form, wind up fitting together like so:

```swift
class SimpleContentElementTableView<Element:ContentElement,Presenter:ContentElmentPresenter> : UIViewController 
  where 
  Element == Presenter.Element {
    let presenter: Presenter
    var rowElements: [Element]
    // etc.
    
    override func viewDidLoad() {
      super.viewDidLoad()
      // register for subsequent dequeuing
      self.presenter.register(with: self.tableView)
      // let's not worry about where `self.tableView` comes from...
    }
}

extension SimpleContentElementTableView : UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
    return self.rowElements.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
    // easy way:
    let element = self.rowElements[indexPath.row]
    let presentation = self.presenter.dequeuePresentation(
      for: element,
      at: indexPath, 
      from: tableView
    )
    self.presenter.populate(
      presentation: presentation,
      at: indexPath,
      in: tableView,
      for: element
    )
    return cell
  }
  
}
```

Despite being over-simplified, the above suffices to convey the core scenario.

Here's where algebraic types come into the picture: to be *practical*--e.g. *worth using*--a system likes the above needs a clean way to handle the common scenario "this table view contains cells of type FooCell, BarCell, BazCell, and QuuxCell, which correspond to data elements Foo, Bar, Baz, and Quux". 

Enter algebraic types: if we have, say, `Sum4<A,B,C,D>` and `Product4<A,B,C,D>`, we can easily add what we need via conditional conformances. Doing so is tedious--the code below is *long*, and we're only at arity 4--but still easy, involving nothing *complicated* whatsoever:

```swift
extension Sum4 : ContentElement 
  where 
  A:ContentElement, 
  B:ContentElement,
  C:ContentElement,
  D:ContentElement {
    // this is a no-op protocol, the real one actually had some stuff here;
    // note that we already have `Equatable` and `Hashable` through `Sum4`
}

// here's the first interesting bit:
extension Sum4 : TableViewCellPresentation 
  where 
  A:TableViewCellPresentation, 
  B:TableViewCellPresentation,
  C:TableViewCellPresentation,
  D:TableViewCellPresentation {
    
    var underlyingTableViewCell: UITableViewCell {
      switch self {
      case .a(let a):
        return a.underlyingTableViewCell
      case .b(let b):
        return b.underlyingTableViewCell
      case .c(let c):
        return c.underlyingTableViewCell
      case .d(let d):
        return d.underlyingTableViewCell
      }
    }
}

// here's the other interesting bit:
extension Product4 : ContentElementPresenter
  where 
  A:ContentElementPresenter, 
  B:ContentElementPresenter,
  C:ContentElementPresenter,
  D:ContentElementPresenter {
  
    // "the sum of the elements is the element of the product"
    typealias Element = Sum4<
      A.Element,
      B.Element,
      C.Element,
      D.Element
    >
    
    // "the sum of the presentations is the presentation of the product"
    typealias Presentation = Sum4<
      A.Element,
      B.Element,
      C.Element,
      D.Element
    >
    
    /// Set ourselves up for subsequent dequeuement.
    func register(with tableView: UITableView) {
      self.a.register(with: tableView)
      self.b.register(with: tableView)
      self.c.register(with: tableView)
      self.d.register(with: tableView)
    }
  
    /// Dequeue the appropriate cell type from the table view.
    func dequeuePresentation(
      for element: Element,
      at indexPath: IndexPath, 
      from tableView: UITableView) -> Presentation {
        // identify *which* elemenet we are, dispatch to appropriate
        // (sub)presenter, dequeue element-appropriate presentation,
        // then return that wrapped as a sum
        switch element {
        case .a(let aElement):
          return .a(
            self.a.dequeuePresentation(
              for: aElement,
              at: indexPath,
              from: tableView
            )
          )
        case .b(let bElement):
          return .b(
            self.b.dequeuePresentation(
              for: bElement,
              at: indexPath,
              from: tableView
            )
          )
        case .c(let cElement):
          return .c(
            self.c.dequeuePresentation(
              for: cElement,
              at: indexPath,
              from: tableView
            )
          )
        case .d(let dElement):
          return .d(
            self.d.dequeuePresentation(
              for: dElement,
              at: indexPath,
              from: tableView
            )
          )
        }
    }
    
    func populate(
      presentation: Presentation,
      at indexPath: IndexPath, 
      in tableView: UITableView,
      for element: Element) {
        switch (presentation,element) {
        case (.a(let aPresentation), .a(let aElement)):
          self.a.populate(
            presentation: aPresentation,
            at: indexPath,
            in: tableView,
            for: aElement
          )
        case (.b(let bPresentation), .b(let bElement)):
          self.b.populate(
            presentation: bPresentation,
            at: indexPath,
            in: tableView,
            for: bElement
          )
        case (.c(let cPresentation), .c(let cElement)):
          self.c.populate(
            presentation: cPresentation,
            at: indexPath,
            in: tableView,
            for: cElement
          )
        case (.d(let dPresentation), .d(let dElement)):
          self.d.populate(
            presentation: dPresentation,
            at: indexPath,
            in: tableView,
            for: dElement
          )
        default:
          // unavoidable with distinct dequeuement and population phases, but
          // we need them distinct in real-world code
          fatalError("Got `Element`/`Presentation` mismatch")
        }
    }
  
}
```

As warned, that's a lot of tedious boilerplate, but (a) you only need to write it once (per arity) and (b) once you have it, the type-safe table view becomes a lot more practical in real life. 

Returning to the `Foo`/`FooCell`, `Bar`/`BarCell`, `Baz`/`BazCell`, and `Quux`/`QuuxCell` scenario, let's assume that `Foo`, `Bar`, `Baz`, and `Quux`, etc., are all "content elements". If we decide to add some additional cell types for special-cases--an initial-state loading cell, a loading more cell, cells for ads, etc., all we need to do at the controller level is some type-level algebra: 

- perhaps we go
  - *from* `Sum4<Foo,Bar,Baz,Quux>` 
  - *to* `Sum8<Foo,Bar,Baz,Quux,Loading,NoData,Error,Ad>`
- perhaps we go 
  - *from* `Sum4<Foo,Bar,Baz,Quux>` 
  - *to* `Sum2<Sum4<Foo,Bar,Baz,Quux>,Sum4<Loading,NoData,Error,Ad>>`
  
...and make the corresponding changes to the code that provides the data feeding our UI. Note that, in particular, in the second option we can already see glimpses of a type-safe, modular, and highly-comoposable UI-programming paradigm: I won't sketch it in detail, but one could imagine a generic type like `DynamicContentLoadingAdapter` that coordinated between:

- a "pure-content data model" like our `Foo`, `Bar` `Baz`, `Quux`
- a "pure-chrome data model" like our `Loading`, `NoData`, `Error`, `Ads`
- some sort of data-loading controller (with compatible types)

...and wind up with a type-safe "transformation" that couples our state-independent, content-level data model from our state-dependent, chrome-level "data model". Such a "transformation" could then be written once-and-forever, too, thereby relegating many annoying, state-dependendent bugs to the internals of that data-loading controller.

## Secondary Motivation

A secondary motivation was a bit narrower in scope: Swift tuples *can't* conform to protocols, and in my experience this *frequently* leads to composability issues with collection-combinators.

Consider an extension like so:

```swift
extension Collection where Element:Equatable {
  
  /// Returns pairs of indices corresponding to any pair of adjacent, duplicate elements.
  func indicesOfAdjacentDuplicates() -> [(Index,Index)] {
    var results: [(Index,Index)] = []
    for (lower,upper) in zip(self.indices,self.indices.dropFirst()) {
      if self[lower] != self[upper] {
        results.append((lower,upper))
      }
    }
  }
  return results
}
```

Missed optimizations aside, we have a composability issue: this won't work on any collection for which the elements are tuples--so we lose composability with things like `zip(_:_:)`, `enumerated()`, or even...`indicesOfAdjacentDuplicates()`! You can patch over this by including a companion, closure-accepting counterpart like so:

```swift
extension CollectionEquatable {
  
  /// Returns pairs of indices corresponding to any pair of adjacent, duplicate elements.
  func indicesOfAdjacentDuplicates(comparator: (Element,Element) -> Bool) -> [(Index,Index)] {
    var results: [(Index,Index)] = []
    for (lower,upper) in zip(self.indices,self.indices.dropFirst()) {
      if !comparator(self[lower],self[upper]) {
        results.append((lower,upper))
      }
    }
  }
  return results
}
```

...but that doesn't *change* the composability issue--it just mitigates it.

## Tertiary Motivation

I used the collections in this library to great effect in a complicated collection view layout system. I hope to open-source that system eventually, but for now let it suffice for me to convey the gist of the use:

- there were three tiers of "layout-controllers"
  - layout-level controllers
  - section-level controllers
  - slot-level controllers
  
...each of which (a) coordinated the layout of the subsequent tier and (b) could include their own independent decorative content; within each tier the decorative content, itself, was coordinated by decorative-content controllers, and was overall *extremely* modular. 

As the API for such layouts requires being able to do an area query--"give me layout information for all elements intersecting this rectangle"--and that's where the collections came into play: the query results were ultimately delivered as a collection, built layer-by-layer from lower-level combinators. Had the `some` keyword been around, it would even have been elegant in form and function; as it was, it *functioned* well, but the form was a bit ungainly.

All else aside, however, this project was a good stress test for the algebraic-programming toolkit. In particular, it revealed that in real use, `ProductN` absoultely will need both the "inline" and "COW" variants at each arity--composition can lead to breakage of all of your otherwise-reasonable assumptions!

## Conclusions

I see the *approach* as more relevant than ever, especially with advent of `SwiftUI`, `Combine`, and so on. SwiftUI arguably induces *less* impedance mismatch between a clean, type-safe UI design and the underlying UI framework; Combine's reactive streams have a lot in common with `Collection`s, and combinators thereof will thus suffer from the very same, tuple-induced composability issues. You can already see this, in fact, in the way that `Combine` includes a lot of algebraic-looking operators taking between 2 and N type parameters.

This package isn't the ideal way to do algebraic programming in the long term, and that'd be true even if I, say, ported it to use GYB and thus could generate higher arities as-necessary.

Much preferable would be language-level support, which I'd split into three steps:

1. introduce anonymous sums, modeled on anonymous products (e.g. tuples)
2. introduce language-level tools to *promote* anonymous sums and products to concrete, nominal types (with controllable protocol derivation)
3. introduce variadic generics, and use that functionality to make protocol derivation extensible

In step 1, we'd, say, gain the ability to write this: `var fooBar: (Foo|Bar)` for *unlabeled* anonymous sums or `var labeledFoobar: (foo: Foo|bar: Bar)`; this syntax is *modeled* on the tuple synatx, merely subsituting `|` for `,`. As with tuples, these would be structural types (e.g. not nominal); as with tuples, also, the enum cases would have well-known, standardized names--either `.0(_)` for a direct analogy, or `.a(_)` for better readability. There'd be no support for recursive anonymous sums because they cannot be written out finitely; I suspect there'd be no need for `indirect`, but I could be wrong about that.

In step 2, we'd introduce a specialized `newtype`-*esque* keyword, used like so:

```swift
newtype Prize<X,Y,Z> : (first: X|second: Y|third: Z)
  conditionally Equatable, Hashable, Comparable, Codable

newtype EightDCoordinate<T:Equatable> : (T,T,T,T,T,T,T,T) 
  unconditionally Equatable, 
  conditionally Hashable, Comparable, Codable
```

The semantics, here, would be that the `newtype` construct auto-synthesizes a type *as-if* you (a) created an appropriate type (`enum Prize...` or `struct EightDCoordinate...`) into the body of which (b) the compiler "pasted in" the same implementation it uses for the indicated nominal type. The remaining syntax is clunky, but illustrates the concept for "controllable derivation": there'd be various derivations *available*, but it'd be up to the user to opt each `newtype` into each desired derivation.

In step 3, finally, the long-awaited variadic generics concept would arise, at which point users would be able to supply their own protocol derivations that could participate in the system sketched above. That's a *long* ways off as I understand it, but between that and language-level macros I think I'd prefer variadic generics for this mechanism.

Going beyond these, there's an obvious algebraic aspect to the algebraic types: the boilerplate is boilerplate, but often expresses algebraic relationships between the types and the underlying code. I'm sure there's some flavor of higher-kinded types--or similarly "exotic" construct--that would provide language-level support for the desired behavior...but I don't know enough to be precise about that, either.