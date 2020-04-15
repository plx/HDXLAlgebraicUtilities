//
//  UniformTrailingTrailingStapleCollection.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: Collection - UniformTrailingStapleCollection Exposure
// -------------------------------------------------------------------------- //

public extension Collection {

  /// Obtain a collection providing the contents of `self` uniformly stapled-together
  /// with the provided `trailing` value.
  @inlinable
  func stapling<Trailing>(
    trailing: Trailing) -> UniformTrailingStapleCollection<Self,Trailing> {
    return UniformTrailingStapleCollection<Self,Trailing>(
      source: self,
      trailing: trailing
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Definition
// -------------------------------------------------------------------------- //

/// Collection wherein each value in `source` is provided with (uniform)
/// trailing "staple" (of type `Trailing`).
public struct UniformTrailingStapleCollection<Source:Collection,Trailing> {
  
  @usableFromInline
  internal var _source: Source
  
  @usableFromInline
  internal var _trailing: Trailing
  
  /// "Designated", componentwise-initializer for `UniformTrailingStapleCollection`.
  ///
  /// Internal for now--as with the mutable properties, etc.--until I get some more
  /// feel for which manipulations and modifications I want to support.
  @inlinable
  internal init(
    source: Source,
    trailing: Trailing) {
    self._source = source
    self._trailing = trailing
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Core API
// -------------------------------------------------------------------------- //

public extension UniformTrailingStapleCollection {
  
  @inlinable
  var source: Source {
    get {
      return self._source
    }
  }
  
  @inlinable
  var trailing: Trailing {
    get {
      return self._trailing
    }
  }

}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Validatable
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        isValidOrIndifferent(self._source),
        isValidOrIndifferent(self._trailing) else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Equatable
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : Equatable
  where
  Source:Equatable,
  Trailing:Equatable {
  
  @inlinable
  public static func ==(
    lhs: UniformTrailingStapleCollection<Source,Trailing>,
    rhs: UniformTrailingStapleCollection<Source,Trailing>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    // note: in many-but-not-all cases trailing should be first, but
    // in others that's super pessimal, so for now...just go in declaration order
    guard
      lhs._source == rhs._source,
      rhs._trailing == rhs._trailing else {
        return false
    }
    return true
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Hashable
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : Hashable
  where
  Source:Hashable,
  Trailing:Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._source.hash(into: &hasher)
    self._trailing.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "(source: \(String(describing: self._source)), trailing: \(String(describing: self._trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "UniformTrailingStapleCollection<\(String(reflecting: Source.self)),\(String(reflecting: Trailing.self))>(\(String(reflecting: self._source)), trailing: \(String(reflecting: self._trailing)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Codable
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : Codable
  where
  Source:Codable,
  Trailing:Codable {
  
  // synthesized OK
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Identifiable
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : Identifiable where Source:Identifiable {
  
  public typealias ID = Source.ID
  
  @inlinable
  public var id: ID {
    get {
      return self._source.id
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - Collection
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : Collection {
  
  public typealias Element = TrailingStapleValue<Source.Element,Trailing>
  public typealias Index = Source.Index
  public typealias Indices = Source.Indices
  public typealias SubSequence = UniformTrailingStapleCollection<Source.SubSequence,Trailing>
  
  @inlinable
  public var indices: Indices {
    get {
      return self.source.indices
    }
  }
  
  @inlinable
  public var isEmpty: Bool {
    get {
      return self.source.isEmpty
    }
  }
  
  @inlinable
  public var count: Int {
    get {
      return self.source.count
    }
  }
  
  @inlinable
  public var startIndex: Index {
    get {
      return self.source.startIndex
    }
  }
  
  @inlinable
  public var endIndex: Index {
    get {
      return self.source.endIndex
    }
  }
  
  @inlinable
  public func distance(
    from start: Index,
    to end: Index) -> Int {
    return self.source.distance(
      from: start,
      to: end
    )
  }
  
  @inlinable
  public subscript(index: Index) -> Element {
    get {
      return Element(
        value: self.source[index],
        trailing: self.trailing
      )
    }
  }
  
  @inlinable
  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      return SubSequence(
        source: self.source[bounds],
        trailing: self.trailing
      )
    }
  }
  
  @inlinable
  public func index(after i: Index) -> Index {
    return self.source.index(after: i)
  }
  
  @inlinable
  public func formIndex(after i: inout Index) {
    self.source.formIndex(after: &i)
  }
  
  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int) -> Index {
    return self.source.index(
      i,
      offsetBy: distance
    )
  }
  
  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int) {
    self.source.formIndex(
      &i,
      offsetBy: distance
    )
  }

  @inlinable
  public func index(
    _ i: Index,
    offsetBy distance: Int,
    limitedBy limit: Index) -> Index? {
    return self.source.index(
      i,
      offsetBy: distance,
      limitedBy: limit
    )
  }

  @inlinable
  public func formIndex(
    _ i: inout Index,
    offsetBy distance: Int,
    limitedBy limit: Index) -> Bool {
    return self.source.formIndex(
      &i,
      offsetBy: distance,
      limitedBy: limit
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - BidirectionalCollection
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : BidirectionalCollection where Source:BidirectionalCollection {
  
  @inlinable
  public func index(before i: Index) -> Index {
    return self.source.index(before: i)
  }
  
  @inlinable
  public func formIndex(before i: inout Index) {
    self.source.formIndex(before: &i)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: UniformTrailingStapleCollection - RandomAccessCollection
// -------------------------------------------------------------------------- //

extension UniformTrailingStapleCollection : RandomAccessCollection where Source:RandomAccessCollection {

}
