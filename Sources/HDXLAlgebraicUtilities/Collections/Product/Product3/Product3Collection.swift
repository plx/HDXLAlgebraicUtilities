//
//  Product3Collection.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Definition
// -------------------------------------------------------------------------- //

/// Collection offering the 9-way cartesian product of its constituent collections.
///
/// Iteration *will* visit every member of that cartesian product, but consider the specific iteration order
/// very much a private implementation detail (and thus potentially subject to change).
@frozen
public struct Product3Collection<A,B,C,Position,Element>
where
  A:Collection,
  B:Collection,
  C:Collection,
  Position:AlgebraicProduct3,
  Position.A == A.Index,
  Position.B == B.Index,
  Position.C == C.Index,
  Element:AlgebraicProduct3,
  Element.A == A.Element,
  Element.B == B.Element,
  Element.C == C.Element {
  
  @usableFromInline
  internal typealias Storage = Product3CollectionStorage<A,B,C,Position,Element>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C) {
    self.init(
      storage: Storage(
        a,
        b,
        c
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Cache Support
// -------------------------------------------------------------------------- //

internal extension Product3Collection {
  
  /// Forcibly-populates all private cached values.
  ///
  /// - note: Private utility, motivated for use with parallel iteration/visiting/etc..
  ///
  @inlinable
  func fullyPopulateCaches() {
    self.storage.fullyPopulateCaches()
  }
  
  /// `true` iff all private cached values have been populated.
  ///
  /// - note: Private utility, motivated for use with parallel iteration/visiting/etc..
  ///
  @inlinable
  var hasFullyPopulatedCaches: Bool {
    get {
      return self.storage.hasFullyPopulatedCaches
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Conveniences
// -------------------------------------------------------------------------- //

public extension Product3Collection {

  /// Retrieves the component-wise counts.
  @inlinable
  var constituentCounts: UniformInlineProduct3<Int> {
    get {
      return self.storage.constituentCounts
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - With Derivation
// -------------------------------------------------------------------------- //

public extension Product3Collection {
  
  @inlinable
  func with(a: A) -> Product3Collection<A,B,C,Position,Element> {
    return Product3Collection<A,B,C,Position,Element>(
      storage: self.storage.with(
        a: a
      )
    )
  }
  
  @inlinable
  func with(b: B) -> Product3Collection<A,B,C,Position,Element> {
    return Product3Collection<A,B,C,Position,Element>(
      storage: self.storage.with(
        b: b
      )
    )
  }
  
  @inlinable
  func with(c: C) -> Product3Collection<A,B,C,Position,Element> {
    return Product3Collection<A,B,C,Position,Element>(
      storage: self.storage.with(
        c: c
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Property Exposure
// -------------------------------------------------------------------------- //

public extension Product3Collection {
  
  @inlinable
  var a: A {
    get {
      return self.storage.a
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(newValue))
      pedantic_assert(self.isValid)
      defer { pedantic_assert(self.isValid) }
      defer { pedantic_assert(isKnownUniquelyReferenced(&self.storage)) }
      // ///////////////////////////////////////////////////////////////////////
      if isKnownUniquelyReferenced(&self.storage) {
        self.storage.a = newValue
      } else {
        self.storage = self.storage.with(
          a: newValue
        )
      }
    }
  }

  @inlinable
  var b: B {
    get {
      return self.storage.b
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(newValue))
      pedantic_assert(self.isValid)
      defer { pedantic_assert(self.isValid) }
      defer { pedantic_assert(isKnownUniquelyReferenced(&self.storage)) }
      // ///////////////////////////////////////////////////////////////////////
      if isKnownUniquelyReferenced(&self.storage) {
        self.storage.b = newValue
      } else {
        self.storage = self.storage.with(
          b: newValue
        )
      }
    }
  }

  @inlinable
  var c: C {
    get {
      return self.storage.c
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(isValidOrIndifferent(newValue))
      pedantic_assert(self.isValid)
      defer { pedantic_assert(self.isValid) }
      defer { pedantic_assert(isKnownUniquelyReferenced(&self.storage)) }
      // ///////////////////////////////////////////////////////////////////////
      if isKnownUniquelyReferenced(&self.storage) {
        self.storage.c = newValue
      } else {
        self.storage = self.storage.with(
          c: newValue
        )
      }
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Validatable
// -------------------------------------------------------------------------- //

extension Product3Collection : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isValid
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Equatable
// -------------------------------------------------------------------------- //

extension Product3Collection : Equatable
  where
  A:Equatable,
  B:Equatable,
  C:Equatable {
  
  @inlinable
  public static func ==(
    lhs: Product3Collection<A,B,C,Position,Element>,
    rhs: Product3Collection<A,B,C,Position,Element>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }

}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Hashable
// -------------------------------------------------------------------------- //

extension Product3Collection : Hashable
  where
  A:Hashable,
  B:Hashable,
  C:Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.storage.hash(into: &hasher)
  }

}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Codable
// -------------------------------------------------------------------------- //

extension Product3Collection : Codable
  where
  A:Codable,
  B:Codable,
  C:Codable {
  
  @inlinable
  public func encode(to encoder: Encoder) throws {
    var value = encoder.singleValueContainer()
    try value.encode(self.storage)
  }
  
  @inlinable
  public init(from decoder: Decoder) throws {
    let value = try decoder.singleValueContainer()
    self.init(
      storage: try value.decode(Storage.self)
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - Collection
// -------------------------------------------------------------------------- //

extension Product3Collection : Collection {

  public typealias Index = Product3CollectionIndex<Position>
  
//  public typealias Indices = Product3CollectionIndices<
//    A,
//    B,
//    C,
//    D,
//    E,
//    F,
//    G,
//    H,
//    I
//  >
  
//  public typealias SubSequence = Product3Collection<
//    A.SubSequence,
//    B.SubSequence,
//    C.SubSequence,
//    D.SubSequence,
//    E.SubSequence,
//    F.SubSequence,
//    G.SubSequence,
//    H.SubSequence,
//    I.SubSequence
//  >
//
  
  @inlinable
  public var isEmpty: Bool {
    get {
      return self.storage.isEmpty
    }
  }
  
  @inlinable
  public var count: Int {
    get {
      return self.storage.count
    }
  }
  
  @inlinable
  public var startIndex: Index {
    get {
      return self.storage.startIndex
    }
  }

  @inlinable
  public var endIndex: Index {
    get {
      return self.storage.endIndex
    }
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index) -> Int {
    guard start != end else {
      return 0
    }
    return (
      self.linearizedIndex(forIndex: end)
      -
      self.linearizedIndex(forIndex: start)
    )
  }
  
  @inlinable
  internal func linearizedIndex(forIndex index: Index) -> Int {
    switch index.storage {
    case .position(let position):
      return self.storage.linearPosition(
        forPosition: position
      )
    case .end:
      return self.count
    }
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    get {
      switch index.storage {
      case .position(let position):
        return self.storage[position]
      case .end:
        preconditionFailure("Attempted to subscript the `endIndex` on \(String(reflecting: self))!")
      }
    }
  }
  
  @inlinable
  public func index(
    after i: Index) -> Index {
    switch i.storage {
    case .position(let position):
      guard let nextPosition = self.storage.position(after: position) else {
        return self.endIndex
      }
      return Index(position: nextPosition)
    case .end:
      preconditionFailure("Attempted to advance from the `endIndex` on \(String(reflecting: self))!")
    }
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int) -> Index {
    let linearizedIndex = self.linearizedIndex(forIndex: i)
    let destination = linearizedIndex + distance
    guard (0...self.count).contains(destination) else {
      preconditionFailure("Invalid navigation to `\(destination)` (as \(linearizedIndex) offsetBy: \(distance), originally \(String(reflecting: i))!")
    }
    guard destination < self.count else {
      return self.endIndex
    }
    return Index(
      position: self.storage.position(
        forLinearPosition: destination
      )
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index) -> Index? {
    let linearizedIndex = self.linearizedIndex(forIndex: i)
    let linearizedLimit = self.linearizedIndex(forIndex: limit)
    let destination = linearizedIndex + distance
    if distance > 0 && destination > linearizedLimit {
      return nil
    } else if distance < 0 && destination < linearizedLimit {
      return nil
    }
    guard (0...self.count).contains(destination) else {
      preconditionFailure("Invalid navigation to `\(destination)` (as \(linearizedIndex) offsetBy: \(distance), originally \(String(reflecting: i))!")
    }
    guard destination < self.count else {
      return self.endIndex
    }
    return Index(
      position: self.storage.position(
        forLinearPosition: destination
      )
    )

  }

}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension Product3Collection : BidirectionalCollection
  where
  A:BidirectionalCollection,
  B:BidirectionalCollection,
  C:BidirectionalCollection {
  
  @inlinable
  public func index(
    before i: Index) -> Index {
    switch i.storage {
    case .position(let position):
      guard let previousPosition = self.storage.position(before: position) else {
        preconditionFailure("Attempted to go back from the `startIndex` on \(String(reflecting: self))!")
      }
      return Index(position: previousPosition)
    case .end:
      guard let finalPosition = self.storage.finalPosition else {
        preconditionFailure("Attempted to go back from the `endIndex` in an empty \(String(reflecting: self))!")
      }
      return Index(position: finalPosition)
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: Product3Collection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension Product3Collection : RandomAccessCollection
  where
  A:RandomAccessCollection,
  B:RandomAccessCollection,
  C:RandomAccessCollection {
  
}

