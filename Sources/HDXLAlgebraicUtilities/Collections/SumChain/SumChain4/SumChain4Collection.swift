//
//  SumChain4Collection.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Definition
// -------------------------------------------------------------------------- //

/// A collection providing the contents of its constituent collections, one after the other.
@frozen
public struct SumChain4Collection<
  A:Collection,
  B:Collection,
  C:Collection,
  D:Collection> {
  
  @usableFromInline
  internal typealias Storage = SumChain4CollectionStorage<A,B,C,D>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(storage.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self.storage = storage
  }
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D) {
    self.init(
      storage: Storage(
        a,
        b,
        c,
        d
      )
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Property Exposure
// -------------------------------------------------------------------------- //

public extension SumChain4Collection {
  
  @inlinable
  var a: A {
    get {
      return self.storage.a
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
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
  
  @inlinable
  var d: D {
    get {
      return self.storage.d
    }
    set {
      // ///////////////////////////////////////////////////////////////////////
      pedantic_assert(self.isValid)
      defer { pedantic_assert(self.isValid) }
      defer { pedantic_assert(isKnownUniquelyReferenced(&self.storage)) }
      // ///////////////////////////////////////////////////////////////////////
      if isKnownUniquelyReferenced(&self.storage) {
        self.storage.d = newValue
      } else {
        self.storage = self.storage.with(
          d: newValue
        )
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Reflection Support
// -------------------------------------------------------------------------- //

internal extension SumChain4Collection {
  
  @inlinable
  static var shortTypeName: String {
    get {
      return "SumChain4Collection"
    }
  }
  
  @inlinable
  static var completeTypeName: String {
    get {
      return "\(self.shortTypeName)<\(self.typeParameterNames)>"
    }
  }
  
  @inlinable
  static var typeParameterNames: String {
    get {
      return [
        String(reflecting: A.self),
        String(reflecting: B.self),
        String(reflecting: C.self),
        String(reflecting: D.self)
        ].joined(separator: ", ")
    }
  }
  
  @inlinable
  var parameterDescriptions: String {
    get {
      return [
        String(reflecting: self.a),
        String(reflecting: self.b),
        String(reflecting: self.c),
        String(reflecting: self.d)
        ].joined(separator: ", ")
      
    }
  }
  
  @inlinable
  var parameterDebugDescriptions: String {
    get {
      return [
        "a: \(String(reflecting: self.a))",
        "b: \(String(reflecting: self.b))",
        "c: \(String(reflecting: self.c))",
        "d: \(String(reflecting: self.d))"
        ].joined(separator: ", ")
      
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Validatable
// -------------------------------------------------------------------------- //

extension SumChain4Collection : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      return self.storage.isValid
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Equatable
// -------------------------------------------------------------------------- //

extension SumChain4Collection : Equatable
  where
  A:Equatable,
  B:Equatable,
  C:Equatable,
  D:Equatable {
  
  @inlinable
  public static func ==(
    lhs: SumChain4Collection<A,B,C,D>,
    rhs: SumChain4Collection<A,B,C,D>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.storage == rhs.storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Hashable
// -------------------------------------------------------------------------- //

extension SumChain4Collection : Hashable
  where
  A:Hashable,
  B:Hashable,
  C:Hashable,
  D:Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self.storage.hash(into: &hasher)
  }
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension SumChain4Collection : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "( \(self.parameterDescriptions) )"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension SumChain4Collection : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "\(type(of: self).completeTypeName)(\(self.parameterDebugDescriptions)"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Codable
// -------------------------------------------------------------------------- //

extension SumChain4Collection : Codable
  where
  A:Codable,
  B:Codable,
  C:Codable,
  D:Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - Collection
// -------------------------------------------------------------------------- //

extension SumChain4Collection : Collection {
  
  public typealias Element = Sum4<
    A.Element,
    B.Element,
    C.Element,
    D.Element
  >
  
  public typealias Index = SumChain4CollectionIndex<A,B,C,D>
  
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
  public subscript(index: Index) -> Element {
    get {
      switch index.storage {
      case .position(let position):
        return self.storage[position]
      case .end:
        preconditionFailure("Tried to subscript the end index on \(String(reflecting: self))!")
      }
    }
  }
  
  @inlinable
  internal func linearIndex(forIndex index: Index) -> Int {
    switch index.storage {
    case .position(let position):
      return self.storage.linearPosition(forPosition: position)
    case .end:
      return self.count
    }
  }
  
  @inlinable
  internal func index(forLinearIndex linearIndex: Int) -> Index {
    guard (0...self.count).contains(linearIndex) else {
      preconditionFailure("Attempted to convert invalid linearIndex \(linearIndex) to index in \(String(reflecting: self))!")
    }
    guard linearIndex < self.count else {
      return self.endIndex
    }
    return Index(
      position: self.storage.position(
        forLinearPosition: linearIndex
      )
    )
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index) -> Int {
    return (
      self.linearIndex(forIndex: end)
        -
        self.linearIndex(forIndex: start)
    )
  }
  
  @inlinable
  public func index(after index: Index) -> Index {
    switch index.storage {
    case .position(let position):
      guard let nextPosition = self.storage.position(after: position) else {
        return self.endIndex
      }
      return Index(position: nextPosition)
    case .end:
      preconditionFailure("Tried to advance the end index on \(String(reflecting: self))!")
    }
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int) -> Index {
    return self.index(
      forLinearIndex: (
        self.linearIndex(forIndex: i)
          +
        distance
      )
    )
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index) -> Index? {
    let destination = self.linearIndex(forIndex: i) + distance
    let boundary = self.linearIndex(forIndex: limit)
    if distance < 0 {
      guard boundary <= destination else {
        return nil
      }
      return self.index(forLinearIndex: destination)
    } else if distance > 0 {
      guard destination <= boundary else {
        return nil
      }
      return self.index(forLinearIndex: destination)
    } else {
      return i
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension SumChain4Collection : BidirectionalCollection
  where
  A:BidirectionalCollection,
  B:BidirectionalCollection,
  C:BidirectionalCollection,
  D:BidirectionalCollection {
  
  @inlinable
  public func index(before index: Index) -> Index {
    precondition(index > self.startIndex)
    switch index.storage {
    case .position(let position):
      guard let previousPosition = self.storage.position(before: position) else {
        preconditionFailure("Tried to go back from the start index in \(String(reflecting: self))!")
      }
      return Index(position: previousPosition)
    case .end:
      guard let finalPosition = self.storage.finalPosition else {
        preconditionFailure("Tried to go back from the start index in \(String(reflecting: self))!")
      }
      return Index(position: finalPosition)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: SumChain4Collection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension SumChain4Collection : RandomAccessCollection
  where
  A:RandomAccessCollection,
  B:RandomAccessCollection,
  C:RandomAccessCollection,
  D:RandomAccessCollection {
  
}

